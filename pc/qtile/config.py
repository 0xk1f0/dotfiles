#          __  _ __           __  ___________
#   ____ _/ /_(_) /__        / /_<  / __/ __ \
#  / __ `/ __/ / / _ \______/ //_/ / /_/ / / /
# / /_/ / /_/ / /  __/_____/ ,< / / __/ /_/ /
# \__, /\__/_/_/\___/     /_/|_/_/_/  \____/
#   /_/

import os
import subprocess
from libqtile import layout, hook, widget, bar
from libqtile.command.graph import _WidgetGraphNode
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
import themes

# initial config
mod = "mod4"
terminal = "kitty"
applauncher = "rofi"
filemanager = "pcmanfm"
scriptPath = "/home/k1f0/.config/scripts/"
home = os.path.expanduser('~')
currentTheme = themes.grey
rofiPower = f"rofi -show power-menu -modi 'power-menu:{scriptPath}rofi-power.sh --no-symbols --choices=shutdown/reboot/logout'"
rofiScreenshot = f"rofi -show screenshot -modi 'screenshot:{scriptPath}rofiScreenshot.sh'"

# theming
accentNormal=currentTheme["accentNormal"]
accentUrgent=currentTheme["accentUrgent"]
accentActive=currentTheme["accentActive"]
accentForeground=currentTheme["accentForeground"]
accentBackground=currentTheme["accentBackground"]
accentModBackground=currentTheme["accentModuleBackground"]
barHeight=24
accentModSpace=5
layoutmargin=8
sideSpace=layoutmargin
font="Open Sans Semibold"
fontsize=int(barHeight/2)
bordersize=2

# key binds
keys = [
    # move windows
    Key([mod], "Right", lazy.next_screen(), desc="Toggle between screens"),
    Key([mod], "Left", lazy.prev_screen(), desc="Toggle between screens"),
    Key([mod], "Up", lazy.group.next_window(), desc="Move focus down"),
    Key([mod], "Down", lazy.group.prev_window(), desc="Move focus up"),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "mod1"], "Down", lazy.layout.flip_down(), desc="Flip Layout downwards"),
    Key([mod, "mod1"], "Up", lazy.layout.flip_up(), desc="Flip Layout upwards"),
    Key([mod, "mod1"], "Left", lazy.layout.flip_left(), desc="Flip Layout leftside"),
    Key([mod, "mod1"], "Right", lazy.layout.flip_right(), desc="Flip Layout rightside"),
    Key([mod, "control"], "Left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "shift"], "n", lazy.layout.normalize(), desc="Normalize Layout"),

    # modify windows / layout
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "b", lazy.window.bring_to_front(), desc="Bring Window to front"),
    Key([mod], "s", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "Right", lazy.next_screen(), desc="Toggle between screens"),
    Key([mod], "Left", lazy.prev_screen(), desc="Toggle between screens"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "shift"], "q", lazy.spawn(rofiPower), desc="Power Menu"),

    # custom keybinds
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "a", lazy.spawn(f"{applauncher} -show run"), desc="Launch rofi run"),
    Key([mod, "shift"], "a", lazy.spawn(f"{applauncher} -show calc -modi calc -no-show-match -no-sort"), desc="Launch rofi calc"),
    Key([mod, "shift"], "w", lazy.spawn(f"{applauncher} -show window"), desc="Launch rofi window"),
    Key([mod], "l", lazy.spawn(f"{scriptPath}i3lock.sh"), desc="Lock Screen"),
    Key([mod], "q", lazy.spawn(filemanager), desc="Lock Screen"),
    Key([mod, "shift"], "s", lazy.spawn(rofiScreenshot), desc="Take Screen"),

    # fn keybinds
    Key([], "XF86AudioLowerVolume", lazy.spawn(f"{scriptPath}volumeDown.sh")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(f"{scriptPath}volumeUp.sh")),
    Key([], "XF86AudioMute", lazy.spawn(f"{scriptPath}volumeMute.sh")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"))
]

# mouse binds
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

# add groups
groups = [
    Group(name="1", label="I"),
    Group(name="2", label="II"),
    Group(name="3", label="III"),
    Group(name="4", label="IV"),
    Group(name="5", label="V"),
]

for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(),),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=False)),
    ])

layout_border = dict(
    border_focus = accentActive,
    border_normal = accentNormal,
    border_width = bordersize,
    border_on_single = True,
)

layouts = [
    layout.Bsp(**layout_border,
        margin = layoutmargin,
        fair = True,
        grow_amount = 5
    ),
    layout.Floating(**layout_border),
]

floating_layout = layout.Floating(**layout_border, float_rules=[
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),
    Match(wm_class='makebranch'),
    Match(wm_class='maketag'),
    Match(wm_class='ssh-askpass'),
    Match(title='branchdialog'),
    Match(title='pinentry'),
    Match(wm_class='confirm'),
    Match(wm_class='dialog'),
    Match(wm_class='download'),
    Match(wm_class='error'),
    Match(wm_class='file_progress'),
    Match(wm_class='notification'),
    Match(wm_class='splash'),
    Match(wm_class='pinentry'),
    Match(wm_class="telegram-desktop"),
    Match(wm_class="signal"),
    Match(wm_class="nomacs"),
    Match(wm_class="Zathura"),
])

#widget settings
widget_defaults = dict(
    font=font,
    fontsize=fontsize,
    background=accentBackground,
    foreground=accentForeground,
    padding=6
)
extension_defaults = widget_defaults.copy()

sep_default = dict(
    size_percent=100
)

#add screen
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(
                    length=sideSpace
                ),
                widget.GroupBox(
                    background=accentModBackground,
                    other_screen_border=accentNormal,
                    other_current_screen_border=accentNormal,
                    this_screen_border=accentActive,
                    this_current_screen_border=accentActive,
                    active=accentActive,
                    inactive=accentForeground,
                    urgent_border=accentUrgent,
                    highlight_method="border",
                    borderwidth=bordersize,
                    padding=2,
                    rounded=False,
                    disable_drag=True,
                    use_mouse_wheel=False,
                    font="Roboto Regular"
                ),
                widget.Spacer(
                    length=accentModSpace
                ),
                widget.CurrentScreen(
                    background=accentModBackground,
                    inactive_color=accentNormal,
                    inactive_text="idl",
                    active_color=accentActive,
                    active_text="act"
                ),
                widget.Spacer(
                    length=accentModSpace
                ),
                widget.CurrentLayout(
                    background=accentModBackground
                ),
                widget.Spacer(),
                widget.CPU(
                    background=accentModBackground,
                    update_interval=3,
                    format='cpu {load_percent}%'
                ),
                widget.Spacer(
                    length=accentModSpace
                ),
                widget.Clock(
                    background=accentModBackground,
                    format='%a, %d.%m.%y - %H:%M:%S'
                ),
                widget.Spacer(
                    length=accentModSpace
                ),
                widget.Memory(
                    background=accentModBackground,
                    update_interval=3,
                    format='mem {MemPercent}%'
                ),
                widget.Spacer(),
                widget.Net(
                    background=accentModBackground,
                    interface="eth",
                    format='{interface} {up} - {down}'
                ),
                widget.Spacer(
                    length=sideSpace
                ),
            ],
            barHeight,
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(
                    length=sideSpace
                ),
                widget.GroupBox(
                    background=accentModBackground,
                    other_screen_border=accentNormal,
                    other_current_screen_border=accentNormal,
                    this_screen_border=accentActive,
                    this_current_screen_border=accentActive,
                    active=accentActive,
                    inactive=accentForeground,
                    urgent_border=accentUrgent,
                    highlight_method="border",
                    borderwidth=bordersize,
                    padding=2,
                    rounded=False,
                    disable_drag=True,
                    use_mouse_wheel=False,
                    font="Roboto Regular"
                ),
                widget.Spacer(
                    length=accentModSpace
                ),
                widget.CurrentScreen(
                    background=accentModBackground,
                    inactive_color=accentNormal,
                    inactive_text="idl",
                    active_color=accentActive,
                    active_text="act"
                ),
                widget.Spacer(
                    length=accentModSpace
                ),
                widget.CurrentLayout(
                    background=accentModBackground
                ),
                widget.Spacer(),
                widget.Clock(
                    background=accentModBackground,
                    format='%a, %d.%m.%y - %H:%M:%S'
                ),
                widget.Spacer(),
                widget.Net(
                    background=accentModBackground,
                    interface="enp34s0",
                    format='{interface} {up} - {down}'
                ),
                widget.Spacer(
                    length=sideSpace
                ),
            ],
            barHeight,
        ),
    )
]

# bools
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "urgent"
reconfigure_screens = True
auto_minimize = False
wmname = "qtile"

# autostart
subprocess.call([home + '/.config/scripts/xrandrapply.sh'])
subprocess.call([home + '/.config/qtile/autostart.sh'])

