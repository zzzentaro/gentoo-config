-- hyprland.lua

--------------------
---- MY DEVICES ----
--------------------

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

hl.config({
	input = {
		kb_layout = "us",
		-- Cursor will change focus
		follow_mouse = 1,
		sensitivity = 0,
		accel_profile = "flat",
	},
})

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("gentoo-pipewire-launcher restart &")
	hl.exec_cmd("waybar & hyprpaper & mako &")
	hl.exec_cmd("wl-clip-persist --clipboard regular &")
	hl.exec_cmd("brightnessctl set 50%")
end)

-- Import the theme!
local theme = require("./theme")

---------------------
---- KEYBINDINGS ----
---------------------
local MOD = "SUPER"

-- Switch window
hl.bind(MOD .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(MOD .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(MOD .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(MOD .. " + l", hl.dsp.focus({ direction = "right" }))

-- Move floating window
hl.bind(MOD .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(MOD .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))
hl.bind(MOD .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(MOD .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))

-- Move floating window
hl.bind(
	MOD .. " + CTRL + h",
	hl.dsp.window.move({ x = -25, y = 0, relative = true }),
	{ repeating = true }
)
hl.bind(
	MOD .. " + CTRL + j",
	hl.dsp.window.move({ x = 0, y = 25, relative = true }),
	{ repeating = true }
)
hl.bind(
	MOD .. " + CTRL + k",
	hl.dsp.window.move({ x = 0, y = -25, relative = true }),
	{ repeating = true }
)
hl.bind(
	MOD .. " + CTRL + l",
	hl.dsp.window.move({ x = 25, y = 0, relative = true }),
	{ repeating = true }
)

-- Workspaces
hl.bind(MOD .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(MOD .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(MOD .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(MOD .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(MOD .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(MOD .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(MOD .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(MOD .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(MOD .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(MOD .. " + 0", hl.dsp.focus({ workspace = 10 }))

hl.bind(MOD .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(MOD .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(MOD .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(MOD .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(MOD .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(MOD .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(MOD .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(MOD .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(MOD .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(MOD .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Function keys
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
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("brightnessctl set 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("brightnessctl set 5%-"),
	{ locked = true, repeating = true }
)

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind(
	"XF86AudioPause",
	hl.dsp.exec_cmd("playerctl play-pause"),
	{ locked = true }
)
hl.bind(
	"XF86AudioPlay",
	hl.dsp.exec_cmd("playerctl play-pause"),
	{ locked = true }
)
hl.bind(
	"XF86AudioPrev",
	hl.dsp.exec_cmd("playerctl previous"),
	{ locked = true }
)

-- Death and creation
hl.bind(MOD .. " + CTRL + Q", hl.dsp.window.close())
hl.bind(MOD .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(MOD .. " + CTRL + F", hl.dsp.window.cycle_next({ direction = "down" }))
hl.bind(MOD .. " + SHIFT + F", hl.dsp.window.fullscreen(0))

hl.bind(MOD .. " + ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(MOD .. " + ALT + Q", hl.dsp.exec_cmd("hyprexit"))

local terminal = "alacritty"
hl.bind(MOD .. " + Return", hl.dsp.exec_cmd(terminal))

local terminal_floating = terminal .. " -T floatty"
hl.bind(MOD .. " + ALT + Return", hl.dsp.exec_cmd(terminal_floating))
hl.on("hyprland.start", function()
	hl.exec_cmd(terminal_floating)
end)

local file_manger = "thunar"
hl.bind(MOD .. " + E", hl.dsp.exec_cmd(file_manger))

local browser = "firefox"
hl.bind(MOD .. " + B", hl.dsp.exec_cmd(browser))

local launcher = "fuzzel"
hl.bind(MOD .. " + Space", hl.dsp.exec_cmd(launcher))

hl.bind(MOD .. " + C", hl.dsp.exec_cmd("menu"))

-- Print screen
local psf =
	'$(xdg-user-dir PICTURES)/screenshots/ps_$(date +"%Y%m%d%H%M%S").png'
hl.bind(
	"Print",
	hl.dsp.exec_cmd("grim - | tee " .. psf .. " | swappy -f - -o " .. psf)
)

hl.bind(
	"SHIFT + Print",
	hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f - -o ' .. psf)
)

-- Submap: resize
hl.bind(MOD .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
	hl.bind(
		"h",
		hl.dsp.window.resize({ x = -25, y = 0, relative = true }),
		{ repeating = true }
	)
	hl.bind(
		"j",
		hl.dsp.window.resize({ x = 0, y = -25, relative = true }),
		{ repeating = true }
	)
	hl.bind(
		"k",
		hl.dsp.window.resize({ x = 0, y = 25, relative = true }),
		{ repeating = true }
	)
	hl.bind(
		"l",
		hl.dsp.window.resize({ x = 25, y = 0, relative = true }),
		{ repeating = true }
	)
	hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
	dwindle = {
		preserve_split = true,
	},

	general = {
		layout = "dwindle",

		gaps_in = 4,
		gaps_out = 8,
		border_size = 2,

		col = {
			active_border = theme.primary,
			inactive_border = theme.muted,
		},

		resize_on_border = false,

		allow_tearing = false,
	},

	decoration = {
		rounding = 4,
		rounding_power = 2,

		active_opacity = 1.0,
		inactive_opacity = 0.9,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = theme.muted,
		},

		blur = {
			enabled = true,
			size = 0,
			passes = 4,
			vibrancy = 0,
		},
	},

	animations = {
		enabled = true,
	},

	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = true,
	},
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve(
	"easeOutQuint",
	{ type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } }
)
hl.curve(
	"easeInOutCubic",
	{ type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } }
)
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve(
	"almostLinear",
	{ type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } }
)
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve(
	"easy",
	{ type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 }
)

hl.animation({
	leaf = "global",
	enabled = true,
	speed = 10,
	bezier = "default",
})
hl.animation({
	leaf = "border",
	enabled = true,
	speed = 5.39,
	bezier = "easeOutQuint",
})
hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 4.79,
	spring = "easy",
})
hl.animation({
	leaf = "windowsIn",
	enabled = true,
	speed = 4.1,
	spring = "easy",
	style = "popin 87%",
})
hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 1.49,
	bezier = "linear",
	style = "popin 87%",
})
hl.animation({
	leaf = "fadeIn",
	enabled = true,
	speed = 1.73,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "fadeOut",
	enabled = true,
	speed = 1.46,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 3.03,
	bezier = "quick",
})
hl.animation({
	leaf = "layers",
	enabled = true,
	speed = 3.81,
	bezier = "easeOutQuint",
})
hl.animation({
	leaf = "layersIn",
	enabled = true,
	speed = 4,
	bezier = "easeOutQuint",
	style = "fade",
})
hl.animation({
	leaf = "layersOut",
	enabled = true,
	speed = 1.5,
	bezier = "linear",
	style = "fade",
})
hl.animation({
	leaf = "fadeLayersIn",
	enabled = true,
	speed = 1.79,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "fadeLayersOut",
	enabled = true,
	speed = 1.39,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 1.94,
	bezier = "almostLinear",
	style = "fade",
})
hl.animation({
	leaf = "workspacesIn",
	enabled = true,
	speed = 1.21,
	bezier = "almostLinear",
	style = "fade",
})
hl.animation({
	leaf = "workspacesOut",
	enabled = true,
	speed = 1.94,
	bezier = "almostLinear",
	style = "fade",
})
hl.animation({
	leaf = "zoomFactor",
	enabled = true,
	speed = 7,
	bezier = "quick",
})

-- "Smart gaps" / "No gaps when only"
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({
	name = "no-gaps-wtv1",
	match = { float = false, workspace = "w[tv1]" },
	border_size = 0,
	rounding = 0,
})
hl.window_rule({
	name = "no-gaps-f1",
	match = { float = false, workspace = "f[1]" },
	border_size = 0,
	rounding = 0,
})

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

-- Start of my own config

hl.window_rule({
	match = { title = "floatty" },
	float = true,
	size = "1280 720",
	move = "540 260",
})

hl.window_rule({
	match = { class = "firefox-esr" },
	workspace = "2 silent",
})

hl.window_rule({ match = { title = "Steam" }, workspace = "8 silent" })

hl.window_rule({
	match = { title = "Waydroid" },
	workspace = "9 silent",
	fullscreen = true,
})
hl.window_rule({ match = { class = "osu!" }, workspace = "9 silent" })
hl.window_rule({
	match = { class = "steam_app_0" },
	workspace = "9 silent",
	fullscreen = false,
})
hl.window_rule({
	match = { title = "Endfield" },
	workspace = "9 silent",
	fullscreen = true,
})
hl.window_rule({
	match = { title = "Genshin Impact" },
	workspace = "9 silent",
	fullscreen = true,
})

hl.window_rule({
	match = { title = "ProtonPlus" },
	workspace = "10 silent",
})
hl.window_rule({
	match = { class = "org.prismlauncher.PrismLauncher" },
	workspace = "10 silent",
})
hl.window_rule({
	match = { class = "moe.launcher.an-anime-game-launcher" },
	workspace = "10 silent",
})
hl.window_rule({
	match = { title = "Heroic Games Launcher" },
	workspace = "10 silent",
})
