-- ════════════════════════════════════════════════
-- Variables
-- ════════════════════════════════════════════════

local mainMod = "SUPER"
local scripts = os.getenv("HOME") .. "/.config/hypr/scripts"

local terminal    = "ghostty"
local fileManager = "thunar"
local browser     = "zen-browser"
local notes       = "obsidian"
local calculator  = "qalculate-gtk"
local menu        = "dms ipc call spotlight toggle"


-- ════════════════════════════════════════════════
-- Application Launchers
-- ════════════════════════════════════════════════

hl.bind(mainMod .. " + RETURN",   hl.dsp.exec_cmd(scripts .. "/play-sound.sh macos-pop & " .. terminal))
hl.bind(mainMod .. " + E",        hl.dsp.exec_cmd(scripts .. "/play-sound.sh menu & " .. fileManager))
hl.bind(mainMod .. " + D",        hl.dsp.exec_cmd(scripts .. "/play-sound.sh macos-hero & " .. menu))
hl.bind(mainMod .. " + B",        hl.dsp.exec_cmd(scripts .. "/play-sound.sh macos-glass & " .. browser))
hl.bind(mainMod .. " + O",        hl.dsp.exec_cmd(notes))
hl.bind(mainMod .. " + C",        hl.dsp.exec_cmd(calculator))
hl.bind(mainMod .. " + comma",    hl.dsp.exec_cmd("smile"))
hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd(scripts .. "/wofi-beats.sh"))


-- ════════════════════════════════════════════════
-- System & DMS Controls
-- ════════════════════════════════════════════════

hl.bind("SUPER + space",   hl.dsp.exec_cmd("dms ipc call dock toggle"))
hl.bind("SUPER + V",       hl.dsp.exec_cmd(scripts .. "/play-sound.sh macos-frog & dms ipc call clipboard toggle"))
hl.bind("SUPER + M",       hl.dsp.exec_cmd("dms ipc call processlist toggle"))
hl.bind("SUPER + N",       hl.dsp.exec_cmd("dms ipc call notifications toggle"))
hl.bind("SUPER + period",  hl.dsp.exec_cmd("dms ipc call settings toggle"))
hl.bind("SUPER + X",       hl.dsp.exec_cmd("dms ipc call powermenu toggle"))
hl.bind("SUPER + ALT + L", hl.dsp.exec_cmd(scripts .. "/play-sound.sh lock & dms ipc call lock lock"))
hl.bind("ALT + Tab",       hl.dsp.exec_cmd("dms ipc call hypr toggleOverview"))


-- ════════════════════════════════════════════════
-- General Actions
-- ════════════════════════════════════════════════

hl.bind(mainMod .. " + SHIFT + A",   hl.dsp.exec_cmd(scripts .. "/toggle-animations.sh"))
hl.bind(mainMod .. " + slash",       hl.dsp.exec_cmd(scripts .. "/keybindings.sh"))
hl.bind(mainMod .. " + CTRL + R",   hl.dsp.exec_cmd(scripts .. "/loadconfig.sh"))
hl.bind(mainMod .. " + ALT + C",    hl.dsp.exec_cmd(scripts .. "/border-animated-themes.sh"))
hl.bind(mainMod .. " + CTRL + Q",   hl.dsp.exec_cmd("waypaper"))
hl.bind(mainMod .. " + CTRL + W",   hl.dsp.exec_cmd(scripts .. "/workmode-toggle.sh"))
hl.bind(mainMod .. " + ccedilla",   hl.dsp.exec_cmd(scripts .. "/toggle-lang.sh"))


-- ════════════════════════════════════════════════
-- Window Management
-- ════════════════════════════════════════════════

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(scripts .. "/close.sh"))
hl.bind(mainMod .. " + T", hl.dsp.window.float())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + G", hl.dsp.window.toggle_group())

-- Mouse-driven window management
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Keyboard resize (pixel-based)
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x =  100, y =    0, relative = true }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -100, y =    0, relative = true }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x =    0, y =  100, relative = true }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x =    0, y = -100, relative = true }))


-- ════════════════════════════════════════════════
-- Scrolling Layout (Niri-style)
-- ════════════════════════════════════════════════

-- Navigate between columns
hl.bind(mainMod .. " + H",     hl.dsp.layout("move -col"))
hl.bind(mainMod .. " + L",     hl.dsp.layout("move +col"))
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))

-- Resize column (percentage)
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.layout("colresize -0.05"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.layout("colresize +0.05"))

-- Swap columns
hl.bind(mainMod .. " + CTRL + H", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.layout("swapcol r"))

-- Promote window to its own column
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.layout("promote"))

-- Toggle focus centering behavior
hl.bind(mainMod .. " + Tab", hl.dsp.layout("togglefit"))


-- ════════════════════════════════════════════════
-- Screenshots
-- ════════════════════════════════════════════════

hl.bind("PRINT",         hl.dsp.exec_cmd(scripts .. "/omarchy-cmd-screenshot"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd(scripts .. "/omarchy-cmd-screenshot window"))
hl.bind("CTRL + PRINT",  hl.dsp.exec_cmd(scripts .. "/omarchy-cmd-screenshot output"))


-- ════════════════════════════════════════════════
-- Workspace Management
-- ════════════════════════════════════════════════

-- Workspaces 1–9 via loop; workspace 0 → 10 handled separately
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,               hl.dsp.exec_cmd(scripts .. "/switch_workspace.sh " .. i))
    hl.bind(mainMod .. " + SHIFT + " .. i,       hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + CTRL + " .. i,        hl.dsp.exec_cmd(scripts .. "/moveTo.sh " .. i))
end

hl.bind(mainMod .. " + 0",         hl.dsp.exec_cmd(scripts .. "/switch_workspace.sh 10"))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))
hl.bind(mainMod .. " + CTRL + 0",  hl.dsp.exec_cmd(scripts .. "/moveTo.sh 10"))

-- Workspace cycling
hl.bind(mainMod .. " + mouse_down",  hl.dsp.workspace.switch("e+1"))
hl.bind(mainMod .. " + mouse_up",    hl.dsp.workspace.switch("e-1"))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.workspace.switch("empty"))


-- ════════════════════════════════════════════════
-- Special Workspace (Scratchpad)
-- ════════════════════════════════════════════════

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))


-- ════════════════════════════════════════════════
-- Hardware & Media Keys
-- ════════════════════════════════════════════════

-- Brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -q s +10%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 10%-"))

-- Volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(scripts .. "/play-sound.sh volume-up & pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(scripts .. "/play-sound.sh volume-down & pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(scripts .. "/play-sound.sh volume-mute & wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))

-- Media controls
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"))
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"))

-- System keys
hl.bind("XF86Calculator", hl.dsp.exec_cmd("qalculate-gtk"))
hl.bind("XF86Lock",       hl.dsp.exec_cmd("hyprlock"))

-- Keyboard backlight (SMC devices)
hl.bind("code:238", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +10"))
hl.bind("code:237", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s 10-"))
