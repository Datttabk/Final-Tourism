import websocket, json, base64, time, urllib.request

with urllib.request.urlopen('http://127.0.0.1:9222/json') as r:
    tabs = json.loads(r.read())
target = [t for t in tabs if '8080' in t.get('url', '') or 'Vijayapura' in t.get('title', '')][0]

ws = websocket.create_connection(target['webSocketDebuggerUrl'], suppress_origin=True)
msg_id = 0

def call(method, params=None):
    global msg_id
    msg_id += 1
    req = {'id': msg_id, 'method': method}
    if params:
        req['params'] = params
    ws.send(json.dumps(req))
    while True:
        resp = json.loads(ws.recv())
        if resp.get('id') == msg_id:
            return resp.get('result', {})

def click(x, y):
    call('Input.dispatchMouseEvent', {'type': 'mouseMoved', 'x': x, 'y': y})
    time.sleep(0.05)
    call('Input.dispatchMouseEvent', {'type': 'mousePressed', 'x': x, 'y': y, 'button': 'left', 'clickCount': 1})
    time.sleep(0.05)
    call('Input.dispatchMouseEvent', {'type': 'mouseReleased', 'x': x, 'y': y, 'button': 'left', 'clickCount': 1})

def screenshot(name):
    res = call('Page.captureScreenshot', {'format': 'png'})
    path = f'/Users/dattakambagi/.gemini/antigravity-ide/brain/f2686f76-1b7a-4e83-897d-fcbd2950b8f4/.tempmediaStorage/{name}.png'
    with open(path, 'wb') as f:
        f.write(base64.b64decode(res['data']))
    print(f'Saved {name}.png')

# 1. Enforce 500x844 viewport
call('Emulation.setDeviceMetricsOverride', {
    'width': 500,
    'height': 844,
    'deviceScaleFactor': 2,
    'mobile': True
})

# 2. Hard reload
call('Network.clearBrowserCache')
call('Page.reload', {'ignoreCache': True})
print('Reloading page with ignoreCache=True...')
time.sleep(6)

screenshot('final_refresh_01_home')

# 3. Click Plans tab (x=250, y=810)
print('Opening Plans tab...')
click(250, 810)
time.sleep(1.5)
screenshot('final_refresh_02_plan_1day')

# 4. Click 2 Days I (x=192, y=102)
print('Switching to 2 Days I...')
click(192, 102)
time.sleep(1.2)
screenshot('final_refresh_03_plan_2day_i')

# 5. Click 2 Days II (x=302, y=102)
print('Switching to 2 Days II...')
click(302, 102)
time.sleep(1.2)
screenshot('final_refresh_04_plan_2day_ii')

# 6. Click 3 Days (x=410, y=102)
print('Switching to 3 Days...')
click(410, 102)
time.sleep(1.2)
screenshot('final_refresh_05_plan_3day')

ws.close()
