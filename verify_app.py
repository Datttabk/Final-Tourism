import json
import urllib.request
import websocket
import time
import os
import sys

# 1. Connect to Chrome debugging port 9222
try:
    with urllib.request.urlopen("http://127.0.0.1:9222/json") as resp:
        tabs = json.loads(resp.read().decode())
except Exception as e:
    print(f"Error querying chrome: {e}")
    sys.exit(1)

target = None
for t in tabs:
    if "8080" in t.get("url", "") or "Vijayapura" in t.get("title", ""):
        target = t
        break

if not target:
    target = tabs[0]

ws_url = target["webSocketDebuggerUrl"]
print(f"Connecting to {ws_url} (title: {target.get('title')})")

ws = websocket.create_connection(ws_url)
msg_id = 0

def call(method, params=None):
    global msg_id
    msg_id += 1
    req = {"id": msg_id, "method": method}
    if params:
        req["params"] = params
    ws.send(json.dumps(req))
    while True:
        resp = json.loads(ws.recv())
        if resp.get("id") == msg_id:
            return resp.get("result", {})

# Set mobile viewport 500x844
call("Emulation.setDeviceMetricsOverride", {
    "width": 500,
    "height": 844,
    "deviceScaleFactor": 2,
    "mobile": True
})

# Clear cache and reload
call("Network.clearBrowserCache")
call("Page.reload", {"ignoreCache": True})
print("Reloaded page with ignoreCache=True")
time.sleep(5)

# Take screenshot of whatever is on screen
res = call("Page.captureScreenshot", {"format": "png"})
import base64
os.makedirs("/Users/dattakambagi/.gemini/antigravity-ide/brain/f2686f76-1b7a-4e83-897d-fcbd2950b8f4/.tempmediaStorage", exist_ok=True)
with open("/Users/dattakambagi/.gemini/antigravity-ide/brain/f2686f76-1b7a-4e83-897d-fcbd2950b8f4/.tempmediaStorage/verify_step1_initial.png", "wb") as f:
    f.write(base64.b64decode(res["data"]))
print("Saved verify_step1_initial.png")

ws.close()
