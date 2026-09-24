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

def type_text(text):
    for char in text:
        call('Input.dispatchKeyEvent', {'type': 'keyDown', 'text': char})
        call('Input.dispatchKeyEvent', {'type': 'keyUp'})
        time.sleep(0.02)

def screenshot(name):
    res = call('Page.captureScreenshot', {'format': 'png'})
    path = f'/Users/dattakambagi/.gemini/antigravity-ide/brain/f2686f76-1b7a-4e83-897d-fcbd2950b8f4/.tempmediaStorage/{name}.png'
    with open(path, 'wb') as f:
        f.write(base64.b64decode(res['data']))
    print(f'Saved {name}.png')

# 1. Click Explore tab at bottom (x=150, y=810)
print('Clicking Explore tab...')
click(150, 810)
time.sleep(1.2)
screenshot('explore_01_main')

# 2. Click Search Box at (x=200, y=105)
print('Focusing Search box...')
click(200, 105)
time.sleep(0.5)

# Type Jod Gumbaz
print('Searching Jod Gumbaz...')
type_text('Jod Gumbaz')
time.sleep(1.0)
screenshot('explore_02_jod_gumbaz_card')

# Click the Jod Gumbaz card (x=250, y=300)
print('Opening Jod Gumbaz detail...')
click(250, 300)
time.sleep(1.5)
screenshot('explore_03_jod_gumbaz_detail')

# Click back (x=50, y=35)
print('Going back...')
click(50, 35)
time.sleep(1.0)

# Clear search box and type Savalasanga
print('Clearing search and typing Savalasanga...')
click(460, 105) # clear icon or click box
time.sleep(0.3)
click(200, 105)
# Select all and replace
call('Input.dispatchKeyEvent', {'type': 'rawKeyDown', 'windowsVirtualKeyCode': 65, 'modifiers': 2}) # Cmd+A
time.sleep(0.05)
call('Input.dispatchKeyEvent', {'type': 'rawKeyDown', 'windowsVirtualKeyCode': 8}) # Backspace
time.sleep(0.2)
type_text('Savalasanga')
time.sleep(1.0)
screenshot('explore_04_savalasanga_card')

# Click Savalasanga card
print('Opening Savalasanga detail...')
click(250, 300)
time.sleep(1.5)
screenshot('explore_05_savalasanga_detail')

ws.close()
