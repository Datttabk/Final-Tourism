import http.server
import socketserver
import os
import sys
import mimetypes
import threading
import urllib.parse

mimetypes.add_type('application/wasm', '.wasm')
mimetypes.add_type('application/javascript', '.js')
mimetypes.add_type('application/json', '.json')
mimetypes.add_type('image/svg+xml', '.svg')
mimetypes.add_type('font/ttf', '.ttf')
mimetypes.add_type('font/woff', '.woff')
mimetypes.add_type('font/woff2', '.woff2')

WEB_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), 'build', 'web'))
CACHE = {}
CACHE_LOCK = threading.Lock()

def get_file_from_cache(raw_path):
    with CACHE_LOCK:
        if raw_path in CACHE:
            return CACHE[raw_path]

    safe_rel = raw_path.lstrip('/')
    full_path = os.path.join(WEB_DIR, safe_rel)
    if os.path.isfile(full_path):
        try:
            with open(full_path, 'rb') as f:
                content = f.read()
            mime, _ = mimetypes.guess_type(full_path)
            if not mime:
                if full_path.endswith('.wasm'):
                    mime = 'application/wasm'
                elif full_path.endswith('.js'):
                    mime = 'application/javascript; charset=utf-8'
                elif full_path.endswith('.html'):
                    mime = 'text/html; charset=utf-8'
                else:
                    mime = 'application/octet-stream'
            elif mime.startswith('text/') or mime == 'application/javascript':
                mime += '; charset=utf-8'

            item = (content, mime)
            with CACHE_LOCK:
                CACHE[raw_path] = item
            return item
        except Exception as e:
            sys.stderr.write(f"Error reading {full_path}: {e}\n")
    return None

def background_preloader():
    try:
        for root, _, files in os.walk(WEB_DIR):
            for file in files:
                full = os.path.join(root, file)
                rel = os.path.relpath(full, WEB_DIR)
                web_p = '/' + rel.replace(os.path.sep, '/')
                get_file_from_cache(web_p)
        print(f"[Server] Preloaded {len(CACHE)} assets into memory cache.", flush=True)
    except Exception as e:
        sys.stderr.write(f"Preload error: {e}\n")

class FastCachedHTTPHandler(http.server.BaseHTTPRequestHandler):
    protocol_version = "HTTP/1.1"

    def do_HEAD(self):
        self.send_response_for_path(send_body=False)

    def do_GET(self):
        self.send_response_for_path(send_body=True)

    def send_response_for_path(self, send_body=True):
        raw_path = self.path.split('?')[0].split('#')[0]

        if raw_path == '/api/client':
            parsed = urllib.parse.urlparse(self.path)
            params = urllib.parse.parse_qs(parsed.query)
            t = params.get('type', [''])[0]
            d = params.get('data', [''])[0]
            sys.stderr.write(f"\n>>> [BROWSER {t.upper()}]: {d}\n")
            sys.stderr.flush()
            self.send_response(200)
            self.send_header('Content-Type', 'text/plain')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.send_header('Content-Length', '2')
            self.send_header('Connection', 'close')
            self.end_headers()
            if send_body:
                self.wfile.write(b'OK')
            return

        if raw_path in ('', '/'):
            raw_path = '/index.html'

        item = get_file_from_cache(raw_path)
        if not item:
            if not raw_path.startswith('/assets/') and '.' not in os.path.basename(raw_path):
                item = get_file_from_cache('/index.html')
            if not item:
                self.send_error(404, f"File not found: {raw_path}")
                return

        content, mime = item
        self.send_response(200)
        self.send_header('Content-Type', mime)
        self.send_header('Content-Length', str(len(content)))
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Cross-Origin-Opener-Policy', 'same-origin')
        self.send_header('Cross-Origin-Embedder-Policy', 'credentialless')
        self.send_header('Cache-Control', 'no-cache, must-revalidate')
        self.send_header('Connection', 'close')
        self.end_headers()

        if send_body:
            self.wfile.write(content)

    def log_message(self, format, *args):
        sys.stderr.write(f"[{self.log_date_time_string()}] {args[0]} - {args[1]}\n")

class ThreadedHTTPServer(socketserver.ThreadingMixIn, http.server.HTTPServer):
    daemon_threads = True
    allow_reuse_address = True

if __name__ == '__main__':
    port = 8080
    t = threading.Thread(target=background_preloader, daemon=True)
    t.start()

    server = ThreadedHTTPServer(('0.0.0.0', port), FastCachedHTTPHandler)
    print(f"Vijayapura Tourism server listening on http://localhost:{port}", flush=True)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        server.server_close()
