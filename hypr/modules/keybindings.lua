local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local env = require("modules.environment_variables") -- local variable for terminal & filemanager in keybinding

hl.bind(mainMod .. " + q", hl.dsp.exec_cmd(env.terminal))
local closeWindowBind = hl.bind(mainMod .. " + c", hl.dsp.window.close())

-- closeWindowBind:set_enabled(false)

hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + v", hl.dsp.exec_cmd("kitty -e nvim"))
hl.bind(mainMod .. " + e", hl.dsp.exec_cmd(env.fileManager))
hl.bind(mainMod .. " + n", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + p", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + j", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -show-icons"))
hl.bind(mainMod .. " + l", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + p", hl.dsp.exec_cmd("kitty -e ~/projects/Ly-ric/launch.sh"))

-- SCREENSHOT--
--
hl.bind(
	"Print",
	hl.dsp.exec_cmd(
		[[FILE=~/Pictures/screenshot_$(date +%Y%m%d_%H%M%S).png; grim -g "$(slurp)" "$FILE" && cat "$FILE" | wl-copy]]
	)
)
hl.bind(
	"CTRL + SHIFT + S",
	hl.dsp.exec_cmd(
		[[FILE=~/Pictures/screenshot_$(date +%Y%m%d_%H%M%S).png; grim -g "$(slurp)" "$FILE" && cat "$FILE" | wl-copy]]
	)
)

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Cycle through workspace
hl.bind(mainMod .. " + Escape", hl.dsp.focus({ workspace = "e+1" }))
-- Open a fresh empty workspace
hl.bind(mainMod .. " + t", hl.dsp.focus({ workspace = "empty" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- VOMUNE & BRIGHTNESS CONTROLL
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 1%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--[WAYBAR KEYMAPS]

-- Super+B: bluetooth manager (bluetui)
hl.bind("SUPER + B", hl.dsp.exec_cmd("kitty --class bluetui -e bluetui"))

-- Super+W: wifi manager (nmtui)
hl.bind("SUPER + W", hl.dsp.exec_cmd("kitty --class nmtui -e nmtui"))
