-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 8,
		gaps_out = 12,

		border_size = 0,

		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 18,
		rounding_power = 5,

		-- Change transparency of focused and unfocused windows
		active_opacity = 0.85,
		inactive_opacity = 0.8,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 10,
			passes = 3,
			vibrancy = 0.1696,
			new_optimizations = true,
			contrast = 1.1,
		},
	},

	animations = {
		enabled = true,
	},
})

hl.layer_rule({
	blur = false,
	ignore_alpha = false,
	match = { namespace = "waybar" },
})

-- bouncy overshoot curve
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })

hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 6,
	bezier = "overshot",
	style = "slide",
})
