--     __  ___________        __                     __                __
--    / /_<  / __/ __ \      / /_  __  ______  _____/ /___ _____  ____/ /
--   / //_/ / /_/ / / /_____/ __ \/ / / / __ \/ ___/ / __ `/ __ \/ __  /
--  / ,< / / __/ /_/ /_____/ / / / /_/ / /_/ / /  / / /_/ / / / / /_/ /
-- /_/|_/_/_/  \____/     /_/ /_/\__, / .___/_/  /_/\__,_/_/ /_/\__,_/
--                              /____/_/
--

local ANIMATION_SPEED = 1.15
local USER            = os.getenv("USER")
local SUPER           = "SUPER"
local SUPERSHIFT      = "SUPER + SHIFT"
local SUPERCTRL       = "SUPER + CTRL"
local SUPERALT        = "SUPER + ALT"
local SUPERALTSHIFT   = "SUPER + ALT + SHIFT"
local SCRIPTS         = "/home/" .. USER .. "/.config/scripts"

-- IMPORTS

local funcs = require("lua.functions")
require("lua.user")

-- MAIN

hl.config({
    input = {
        sensitivity = 0,
        follow_mouse = 1,
        mouse_refocus = false,
        repeat_rate = 25,
        repeat_delay = 300,
        accel_profile = "flat",
        kb_model = "pc105",
        kb_layout = "us",
        kb_variant = "altgr-intl",
        numlock_by_default = true,
        natural_scroll = false,
        touchpad = {
            natural_scroll = false,
            scroll_factor = 0.8,
            disable_while_typing = true,
        },
        touchdevice = {
            enabled = false,
        },
    },

    cursor = {
        no_hardware_cursors = 0,
    },

    general = {
        gaps_in = 3,
        gaps_out = 6,
        border_size = 2,
        layout = "dwindle",
        resize_on_border = false,
        allow_tearing = true,
        col = {
            -- group section was setting col.border_active/inactive on groups;
            -- in Lua the group colors live under `group`, see below.
        },
    },

    group = {
        col = {
            border_inactive = "0xFF000000",
            border_active   = COLOR_BORDER,
        },
    },

    decoration = {
        rounding = 0,
        dim_inactive = false,
        dim_strength = 0.25,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 10,
            sharp = false,
            render_power = 4,
            color = COLOR_ACTIVE,
            color_inactive = "0x00000000",
        },
        blur = {
            enabled = true,
            size = 10,
            passes = 1,
            new_optimizations = true,
            xray = true,
            noise = 0.1,
            contrast = 0.7,
            brightness = 0.7,
            vibrancy = 0.15,
            vibrancy_darkness = 0.15,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        smart_resizing = true,
        preserve_split = true,
        use_active_for_splits = true,
        smart_split = false,
    },

    render = {
        direct_scanout = 2,
    },

    misc = {
        vrr = 3,
        layers_hog_keyboard_focus = true,
        animate_manual_resizes = false,
        animate_mouse_windowdragging = false,
        mouse_move_enables_dpms = false,
        key_press_enables_dpms = true,
        mouse_move_focuses_monitor = true,
        disable_hyprland_logo = true,
        disable_splash_rendering = false,
        enable_swallow = false,
        allow_session_lock_restore = false,
    },
})

-- ANIMATIONS

hl.curve("sine", { type = "bezier", points = { { 0.37, 0 }, { 0.63, 1 } } })
hl.curve("in", { type = "bezier", points = { { 0.12, 0 }, { 0.39, 0 } } })
hl.curve("out", { type = "bezier", points = { { 0.61, 1 }, { 0.88, 1 } } })

hl.animation({ leaf = "border", enabled = true, speed = ANIMATION_SPEED, bezier = "sine" })
hl.animation({ leaf = "borderangle", enabled = true, speed = ANIMATION_SPEED, bezier = "sine", style = "once" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = ANIMATION_SPEED, bezier = "sine", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = ANIMATION_SPEED, bezier = "out", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = ANIMATION_SPEED, bezier = "sine" })
hl.animation({ leaf = "fade", enabled = true, speed = ANIMATION_SPEED, bezier = "sine" })
hl.animation({ leaf = "workspaces", enabled = true, speed = ANIMATION_SPEED, bezier = "sine", style = "slide" })
hl.animation({ leaf = "layers", enabled = false })
hl.animation({ leaf = "zoomFactor", enabled = false })
hl.animation({ leaf = "monitorAdded", enabled = false })

-- GESTURES

hl.gesture({
    fingers   = 3,
    direction = "vertical",
    action    = "workspace",
})

-- WINDOW RULES

hl.window_rule({ match = { title = "^$" }, float = true })
hl.window_rule({ match = { class = "org.signal.Signal" }, float = true })
hl.window_rule({ match = { class = "ristretto" }, float = true })
hl.window_rule({ match = { class = "mpv" }, float = true })
hl.window_rule({ match = { class = "vlc" }, float = true })
hl.window_rule({ match = { class = "org.pwmt.zathura" }, float = true })
hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "always" })
hl.window_rule({ match = { class = "^.*(gamescope|gamescope-wl).*$" }, immediate = true })

-- BINDS

hl.bind(SUPER .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(SUPER .. " + Q", hl.dsp.exec_cmd("caja"))
hl.bind(SUPER .. " + A", hl.dsp.exec_cmd("rofi -show run"))
hl.bind(SUPER .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(SUPER .. " + T", hl.dsp.exec_cmd("kitty yazi"))
hl.bind(SUPERSHIFT .. " + S", hl.dsp.exec_cmd(SCRIPTS .. "/wayland/screenshot.sh"))
hl.bind(SUPERSHIFT .. " + Q", hl.dsp.exec_cmd("eww open-many --toggle powermenu-blur powermenu"))
hl.bind(SUPERSHIFT .. " + A", hl.dsp.exec_cmd("rofi -show calc"))
hl.bind(SUPERSHIFT .. " + E", hl.dsp.exec_cmd("rofi -show emoji -emoji-mode copy"))

hl.bind(SUPER .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(SUPER .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(SUPER .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(SUPER .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(SUPER .. " + B", hl.dsp.window.bring_to_top())
hl.bind(SUPERSHIFT .. " + C", hl.dsp.window.close())
hl.bind(SUPERSHIFT .. " + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(SUPERSHIFT .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(SUPERSHIFT .. " + D", hl.dsp.layout("togglesplit"))
hl.bind(SUPERCTRL .. " + F", hl.dsp.window.fullscreen())
hl.bind(SUPERCTRL .. " + S", funcs.toggle_workspace_floating)

hl.bind(SUPER .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(SUPER .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(SUPER .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(SUPER .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(SUPERCTRL .. " + right", hl.dsp.window.move({ monitor = "r" }))
hl.bind(SUPERCTRL .. " + left", hl.dsp.window.move({ monitor = "l" }))

hl.bind(SUPERALT .. " + left", hl.dsp.window.resize({ x = -30, y = 0, relative = true}), { repeating = true })
hl.bind(SUPERALT .. " + right", hl.dsp.window.resize({ x = 30, y = 0, relative = true}), { repeating = true })
hl.bind(SUPERALT .. " + up", hl.dsp.window.resize({ x = 0, y = -30, relative = true}), { repeating = true })
hl.bind(SUPERALT .. " + down", hl.dsp.window.resize({ x= 0, y = 30, relative = true}), { repeating = true })

hl.bind(SUPERALTSHIFT .. " + left", hl.dsp.window.move({ x = -30, y = 0, relative = true}), { repeating = true })
hl.bind(SUPERALTSHIFT .. " + right", hl.dsp.window.move({ x = 30, y = 0, relative = true}), { repeating = true })
hl.bind(SUPERALTSHIFT .. " + up", hl.dsp.window.move({ x = 0, y = -30, relative = true}), { repeating = true })
hl.bind(SUPERALTSHIFT .. " + down", hl.dsp.window.move({ x= 0, y = 30, relative = true}), { repeating = true })

hl.bind(SUPERSHIFT .. " + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(SUPERSHIFT .. " + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(SUPERSHIFT .. " + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(SUPERSHIFT .. " + down", hl.dsp.window.move({ direction = "d" }))

for i = 1, 5 do
    hl.bind(SUPER .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(SUPERSHIFT .. " + " .. i, hl.dsp.window.move({ workspace = i, silent = true }))
end

hl.bind("XF86Calculator", hl.dsp.exec_cmd("rofi -show calc"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(SCRIPTS .. "/volume.sh sink-incr '-' '2'"),
    { repeating = true, locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(SCRIPTS .. "/volume.sh sink-incr '+' '2'"),
    { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(SCRIPTS .. "/volume.sh sink-mute"), { locked = true })
hl.bind("XF86Mail", hl.dsp.exec_cmd(SCRIPTS .. "/volume.sh source-mute"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(SCRIPTS .. "/media.sh next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(SCRIPTS .. "/media.sh prev"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(SCRIPTS .. "/media.sh pp"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(SCRIPTS .. "/brightness.sh down"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(SCRIPTS .. "/brightness.sh up"), { repeating = true, locked = true })

-- EXECS

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/lib/mate-polkit/polkit-mate-authentication-agent-1")
    hl.exec_cmd("nwg-look -a")
    hl.exec_cmd("systemctl --user restart xsettingsd.service")
    hl.exec_cmd("easyeffects --hide-window --service-mode")
    hl.exec_cmd("/home/" .. USER .. "/.config/hypr/hyprinit.sh")
end)
hl.exec_cmd("/home/" .. USER .. "/.config/hypr/hyprinit.sh")
