hl.config({
	general = {
		gaps_in = 8,
		gaps_out = 12,
		gaps_workspaces = 50,
		border_size = 1,
		resize_on_border = true,
		no_focus_fallback = true,
		allow_tearing = true,
		layout = "scrolling",

		-- col = { active_border = "rgb(8aadf4) rgb(24273A) rgb(24273A) rgb(8aadf4) 45deg" },
		-- col = { inactive_border = "rgb(24273A) rgb(24273A) rgb(24273A) rgb(27273A) 45deg" },
		col = { active_border = "rgb(24273A)" },
	},

	decoration = {
		rounding = 6,
		rounding_power = 4.0,
		-- rounding = 0,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		fullscreen_opacity = 1.0,
		border_part_of_window = true,

		shadow = {
			enabled = true,
			range = 20,
			render_power = 3,
			color = "0x66000000",
		},

		blur = {
			enabled = true,
			size = 10,
			passes = 4,
			xray = false,
			ignore_opacity = true,
			new_optimizations = true,
			noise = 0.02,
			contrast = 1.1,
			vibrancy = 0.2,
			vibrancy_darkness = 0.3,
		},

		-- dim_inactive = true,
		-- dim_strength = 0.1,
		-- dim_special = 0.3,
	},

	misc = {
		-- controls the VRR (Adaptive Sync) of your monitors.
		-- 0: off, 1: on, 2: fullscreen only, 3: fullscreen with video or game content type
		vrr = 2,
		animate_manual_resizes = false,
		animate_mouse_windowdragging = false,
		enable_swallow = false,
		swallow_regex = "(com.mitchellh.ghostty|foot|kitty|allacritty|Alacritty)",
		disable_hyprland_logo = true,
		force_default_wallpaper = 0,
		allow_session_lock_restore = true,
		initial_workspace_tracking = 1,
		focus_on_activate = true,
	},

	render = {
		-- Whether the color management pipeline should be enabled or not
		-- (requires a restart of Hyprland to fully take effect)
		cm_enabled = false,

		-- Report content type to allow monitor profile autoswitch
		-- (may result in a black screen during the switch)
		send_content_type = false,
	},

	input = {
		kb_layout = "br",
		kb_variant = "abnt2",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		numlock_by_default = true,
		repeat_delay = 250,
		repeat_rate = 35,
		follow_mouse = 1,
		force_no_accel = true,
		sensitivity = 0,
		accel_profile = "flat",
		special_fallthrough = true,

		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
			clickfinger_behavior = true,
			scroll_factor = 0.5,
		},
	},

	binds = {
		scroll_event_delay = 0,
	},

	cursor = {
		no_hardware_cursors = true,
	},

	xwayland = {
		enabled = true,
		force_zero_scaling = true,
	},
})

-- NOTE: device blocks need hl.device() — verify syntax before enabling
hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })
