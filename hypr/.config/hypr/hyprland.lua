-- Migrated from hyprland.conf (the .conf format is deprecated and its
-- support is removed in Hyprland 0.57+).
-- Reference: https://wiki.hypr.land/Configuring/Start/
-- Default example this migration was based on: /usr/share/hypr/hyprland.lua


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
local Monitor1 = "DP-3"
local Monitor2 = "DP-2"

hl.monitor({ output = Monitor1, mode = "2560x1440@165", position = "auto",      scale = "auto" })
hl.monitor({ output = Monitor2, mode = "highres",       position = "auto-left", scale = "auto" })
hl.monitor({ output = "",       mode = "preferred",      position = "auto",     scale = "auto" })

hl.workspace_rule({ workspace = "1",  monitor = Monitor1, default = true })
hl.workspace_rule({ workspace = "2",  monitor = Monitor1 })
hl.workspace_rule({ workspace = "3",  monitor = Monitor1 })
hl.workspace_rule({ workspace = "4",  monitor = Monitor1 })
hl.workspace_rule({ workspace = "5",  monitor = Monitor1 })
hl.workspace_rule({ workspace = "6",  monitor = Monitor1 })
hl.workspace_rule({ workspace = "7",  monitor = Monitor1 })
hl.workspace_rule({ workspace = "8",  monitor = Monitor1 })
hl.workspace_rule({ workspace = "9",  monitor = Monitor2, default = true })
hl.workspace_rule({ workspace = "10", monitor = Monitor1 })


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "ghostty"
local fileManager = "dolphin"
local menu        = "wofi --show drun"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("bash ~/.config/hypr/start.sh")
    hl.dispatch(hl.dsp.focus({ workspace = 1 }))
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 5,

        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,

        layout = "master",
    },

    decoration = {
        rounding = 10,

        active_opacity   = 0.98,
        inactive_opacity = 0.96,

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = false,
    },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })

hl.config({
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo  = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity   = 0,
        accel_profile = "flat",

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

-- Example per-device config
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
})

-- Sound control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + RETURN",       hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q",    hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E",    hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + R",    hl.dsp.exec_cmd("~/.config/hypr/start.sh"))
hl.bind(mainMod .. " + E",            hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",            hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D",            hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",            hl.dsp.window.pseudo())              -- dwindle
hl.bind(mainMod .. " + J",            hl.dsp.layout("togglesplit"))        -- dwindle only

-- Move focus with mainMod + arrow keys (vim-style)
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.swap({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace (without following) with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + S",     hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))
hl.bind("SHIFT + Print",       hl.dsp.exec_cmd('grim -g "$(slurp -d)"'))


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
hl.window_rule({
    name  = "suppress-maximize-events", -- You'll probably like this.
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name  = "discord-workspace",
    match = { class = "^(discord)$" },

    workspace = "7 silent",
})

hl.window_rule({
    name  = "vesktop-workspace",
    match = { class = "^(vesktop)$" },

    workspace = "7 silent",
})

hl.window_rule({
    name  = "spotify-workspace",
    match = { initial_title = "^(Spotify)(.*)$" },

    workspace = "8 silent",
})
