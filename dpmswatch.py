#!/usr/bin/python2
import json
import subprocess
import time

i3_cmd = 'i3-msg -t get_tree'

def get_layout():
    get_tree = subprocess.Popen(i3_cmd.split(), stdout=subprocess.PIPE)
    stdout = get_tree.communicate()[0]
    try:
        tree = json.loads(stdout)
    except ValueError:
        tree = {}
    return tree

def any_fullscreen_window(node):
    if node['window']:
        return node['fullscreen_mode'] == 1
    return any(any_fullscreen_window(n) for n in node.get('nodes', ''))

def xset_screensaver(arg):
    subprocess.call(["xset", arg])

def check_state():
    if any_fullscreen_window(get_layout()):
        xset_screensaver("-dpms")
    else:
        xset_screensaver("+dpms")

while True:
    check_state()
    time.sleep(240)
