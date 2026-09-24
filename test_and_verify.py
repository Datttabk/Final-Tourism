import json
import urllib.request
import websocket
import time
import os
import sys
import base64

def get_page():
    with urllib.request.urlopen("http://127.0.0.1:9222/json") as resp:
        tabs = json.loads(resp.read().decode())
    for t in tabs:
        if "8080" in t.get("url", "") or "Vijayapura" in t.get("title", ""):
            return t
    return tabs[0]

page = get_page()
ws_url = page["webSocketDebuggerUrl"]
ws = websocket.create_connection(ws_url, suppress_origin=True)
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

def screenshot(name):
    res = call("Page.captureScreenshot", {"format": "png"})
    path = f"/Users/dattakambagi/.gemini/antigravity-ide/brain/f2686f76-1b7a-4e83-897d-fcbd2950b8f4/.tempmediaStorage/{name}.png"
    with open(path, "wb") as f:
        f.write(base64.b64decode(res["data"]))
    print(f"Screenshot saved: {name}.png ({len(res['data'])} bytes)")
    return path

# 1. Set 500x844 mobile viewport
call("Emulation.setDeviceMetricsOverride", {
    "width": 500,
    "height": 844,
    "deviceScaleFactor": 2,
    "mobile": True
})

# 2. Reload with ignoreCache=True
call("Network.clearBrowserCache")
call("Page.reload", {"ignoreCache": True})
print("Page reloaded, waiting 7 seconds...")
time.sleep(7)

screenshot("step1_after_refresh")

ws.close()
