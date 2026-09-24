import json
import urllib.request
import websocket
import time
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

def tap(x, y):
    call("Input.dispatchTouchEvent", {
        "type": "touchStart",
        "touchPoints": [{"x": x, "y": y}]
    })
    time.sleep(0.05)
    call("Input.dispatchTouchEvent", {
        "type": "touchEnd",
        "touchPoints": []
    })
    time.sleep(0.5)

# Click Plans tab (x=250, y=815)
print("Tapping Plans tab...")
tap(250, 815)
time.sleep(1.5)
screenshot("test_plans_tab_main")

# In Plans screen, let's see the route image
# Let's scroll down slightly to ensure route card is visible
print("Scrolling to route card...")
call("Input.dispatchTouchEvent", {
    "type": "touchStart",
    "touchPoints": [{"x": 250, "y": 600}]
})
time.sleep(0.05)
call("Input.dispatchTouchEvent", {
    "type": "touchMove",
    "touchPoints": [{"x": 250, "y": 400}]
})
time.sleep(0.05)
call("Input.dispatchTouchEvent", {
    "type": "touchEnd",
    "touchPoints": []
})
time.sleep(1.0)
screenshot("test_plans_1day_scrolled")

# Now tap the 2-Day I tab chip at top
# Usually chip row is around y=120-140. Let's inspect test_plans_tab_main first.
ws.close()
