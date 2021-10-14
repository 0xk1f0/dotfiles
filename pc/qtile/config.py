# qTile - config - k1f0

import os
import subprocess
import re
import socket
from libqtile import qtile
from libqtile import layout, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from typing import List

mod = "mod4"
terminal = "kitty"
applauncher = "rofi"
filemanager = "nemo"
scriptPath = "/home/k1f0/.config/qtile/scripts/"
home = os.path.expanduser('~')

def reset_after_switch():
    lazy.next_layout()
    lazy.window.toggle_fullscreen()

keys = [
    # move windows
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "control"], "Left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),

    # modify windows / layout
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "s", lazy.function(reset_after_switch), desc="Toggle between layouts"),
    Key([mod], "Tab", lazy.next_screen(), desc="Toggle between screens"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # custom keybinds
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "a", lazy.spawn(f"{applauncher} -show run"), desc="Launch rofi run"),
    Key([mod, "shift"], "a", lazy.spawn(f"{applauncher} -show calc"), desc="Launch rofi calc"),
    Key([mod, "shift"], "w", lazy.spawn(f"{applauncher} -show window"), desc="Launch rofi window"),
    Key([mod], "l", lazy.spawn(f"{scriptPath}i3lock.sh"), desc="Lock Screen"),
    Key([mod], "q", lazy.spawn(filemanager), desc="Lock Screen"),
    Key([mod, "shift"], "s", lazy.spawn(f"{scriptPath}takeScreenshot.sh"), desc="Take Screen"),

    # fn keybinds
    Key([], "XF86AudioLowerVolume", lazy.spawn(f"{scriptPath}volumeDown.sh")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(f"{scriptPath}volumeUp.sh")),
    Key([], "XF86AudioMute", lazy.spawn(f"{scriptPath}volumeMute.sh")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"))
]

# add groups
groups = [
    Group(name="1", label="I", layout="Columns"),
    Group(name="2", label="II", layout="Columns"),
    Group(name="3", label="III", layout="Columns"),
    Group(name="4", label="IV", layout="Columns"),
    Group(name="5", label="V", layout="Columns"),
]

for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=False),
            desc="Switch to & move focused window to group {}".format(i.name)),
    ])

# set layout options
layout_theme = {
    "border_width": 2,
    "margin": 14,
    "border_focus": "#ffffff",
    "border_normal": "333333",
    "border_on_single": True
}

layouts = [
    layout.Columns(**layout_theme),
    layout.Floating(**layout_theme),
]

# add two Screens
screens = [Screen(), Screen()]

# mouse binds
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

# floating settings
floating_layout = layout.Floating(float_rules=[
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),
    Match(wm_class='makebranch'),
    Match(wm_class='maketag'),
    Match(wm_class='ssh-askpass'),
    Match(title='branchdialog'),
    Match(title='pinentry'),
])

# bools
follow_mouse_focus = True
bring_front_click = True
cursor_warp = True
auto_fullscreen = False
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "qTile"

# start important things first and once
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostartOnce.sh')
    subprocess.call([home])
    # apply res+orientation
    subprocess.Popen([home + '/.config/qtile/scripts/xrandrapply.sh'])

# start other thingies last
subprocess.Popen([home + '/.config/qtile/autostart.sh'])
