-- THIS IS A HYPRLAND WM CONFIG FILE
local theme = require("./theme")

-- Connected device
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

-- Start hyprland

-- Export graphics variables
hl.env("LIBVA_DRIVER_NAME", "iHD")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "--[[nvidia]]")
hl.env("__VK_LAYER_NV_optimus", "NVIDIA_only")
hl.env("__NV_PRIME_RENDER_OFFLOAD_PROVIDER", "NVIDIA-GO")
hl.env("__NV_PRIME_RENDER_OFFLOAD", "0")

-- Export toolkit backed variables
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

hl.on("hyprland.start", function()
	hl.exec_cmd("pipewire & pipewire-pulse & wireplumber")
	hl.exec_cmd(
		"waybar & hyprpaper & mako & wl-clip-persist --clipboard regular"
	)
	-- 3) Reset settings
	hl.exec_cmd("brightnessctl set 10% % & powerprofilesctl set power-saver")
end)

-- Bind
local MOD = "SUPER"

hl.bind(MOD .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(MOD .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(MOD .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(MOD .. " + l", hl.dsp.focus({ direction = "right" }))

-- Move tiled window
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

-- Fn
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

hl.bind(MOD .. " + CTRL + Q", hl.dsp.window.close())

hl.bind(MOD .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(MOD .. " + CTRL + F", hl.dsp.window.cycle_next({ direction = "down" }))
hl.bind(MOD .. " + SHIFT + F", hl.dsp.window.fullscreen(0))

hl.bind(MOD .. " + ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(
	MOD .. " + ALT + Q",
	hl.dsp.exec_cmd(
		"command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
	)
)

local terminal = "alacritty"
hl.bind(MOD .. " + Return", hl.dsp.exec_cmd(terminal))
local terminalFloat = "alacritty -T floatty"
hl.on("hyprland.start", function()
	hl.exec_cmd(terminalFloat)
end)
hl.bind(MOD .. " + ALT + Return", hl.dsp.exec_cmd(terminalFloat))

local fileManager = "pcmanfm"
hl.bind(MOD .. " + E", hl.dsp.exec_cmd(fileManager))

local browser = "firefox-bin"
hl.bind(MOD .. " + B", hl.dsp.exec_cmd(browser))

local launcher = "fuzzel"
hl.bind(MOD .. " + Space", hl.dsp.exec_cmd(launcher))

hl.bind(MOD .. " + C", hl.dsp.exec_cmd("menu"))

-- Print screen
local psf =
	'$(xdg-user-dir PICTURES)/Screenshots/ps_$(date +"%Y%m%d%H%M%S").png'
hl.bind(
	"Print",
	hl.dsp.exec_cmd("grim - | tee " .. psf .. " | swappy -f - -o " .. psf)
)

hl.bind(
	"SHIFT + Print",
	hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f - -o ' .. psf)
)

-- Submap: reize
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

-- Appearance
hl.config({
	general = {
		layout = "scrolling",
		gaps_in = 0,
		gaps_out = 0,
		border_size = 2,

		col = {
			active_border = theme.primary,
			inactive_border = theme.muted,
		},

		resize_on_border = false,

		allow_tearing = true,
	},

	scrolling = {
		fullscreen_on_one_column = true,
		focus_fit_method = 1,
		column_width = 0.9,
		direction = "down",
	},

	decoration = {
		rounding = 0,
		rounding_power = 2,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = false,
		},

		blur = {
			enabled = false,
		},
	},

	animations = {
		enabled = true,
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
})

hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("md3_standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve(
	"md3_decel",
	{ type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } }
)
hl.curve(
	"md3_accel",
	{ type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } }
)
hl.curve(
	"overshot",
	{ type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } }
)
hl.curve(
	"crazyshot",
	{ type = "bezier", points = { { 0.1, 1.5 }, { 0.76, 0.92 } } }
)
hl.curve(
	"hyprnostretch",
	{ type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } }
)
hl.curve("fluent_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve(
	"easeInOutCirc",
	{ type = "bezier", points = { { 0.85, 0 }, { 0.15, 1 } } }
)
hl.curve(
	"easeOutCirc",
	{ type = "bezier", points = { { 0, 0.55 }, { 0.45, 1 } } }
)
hl.curve(
	"easeOutExpo",
	{ type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } }
)

hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 3,
	bezier = "md3_decel",
	style = "popin 60%",
})
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 2.5,
	bezier = "md3_decel",
})
hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 3.5,
	bezier = "easeOutExpo",
	style = "slide",
})
hl.animation({
	leaf = "specialWorkspace",
	enabled = true,
	speed = 3,
	bezier = "md3_decel",
	style = "slidevert",
})

-- Rule (latest takes priority)
hl.window_rule({ match = { class = ".*" }, size = "1 1" })

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

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

hl.window_rule({
	name = "float-terminal",
	match = { title = "floatty" },
	float = true,
	move = "12 48",
	size = "1400 1020",
})

hl.window_rule({
	name = "browser",
	match = { class = "firefox" },
	workspace = "2 silent",
})

hl.window_rule({ match = { class = "steam" }, workspace = "8 silent" })
hl.window_rule({ match = { class = "discord" }, workspace = "8 silent" })

hl.window_rule({
	name = "gryphlink",
	match = { title = "GRYPHLINK" },
	workspace = "10 silent",
	float = true,
	rounding = 16,
	border_color = theme.secondary,
})

hl.window_rule({
	name = "hsr",
	match = { class = "moe.launcher.the-honkers-railway-launcher" },
	workspace = "10 silent",
	rounding = 20,
	float = true,
	border_color = theme.tertiary,
})

hl.window_rule({
	match = { class = "Waydroid" },
	workspace = "9 silent",
	fullscreen = true,
})
hl.window_rule({
	match = { title = "Honkai: Star Rail" },
	workspace = "9 silent",
})
hl.window_rule({ match = { class = "osu!" }, workspace = "9 silent" })

hl.window_rule({
	name = "endfield",
	match = { title = "Endfield" },
	workspace = "9 silent",
	rounding = 0,
	fullscreen = true,
})
