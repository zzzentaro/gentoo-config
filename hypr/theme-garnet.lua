-- source: rosepinetheme.com

local base = "191724"
local surface = "1f1d2e"
local overlay = "26233a"
local muted = "6e6a86"
local subtle = "908caa"
local text = "e0def4"
local love = "eb6f92"
local gold = "f6c177"
local rose = "ebbcba"
local pine = "31748f"
local foam = "9ccfd8"
local iris = "c4a7e7"
local highlightLow = "21202e"
local highlightMed = "403d52"
local highlightHigh = "524f67"

local THEME = {
	primary = "rgb(" .. love .. ")",
	primaryAlpha = love,
	secondary = "rgb(" .. gold .. ")",
	tertiary = "rgb(" .. iris .. ")",
}

hl.exec_cmd("hyprctl hyprpaper wallpaper ,~/Pictures/Wallpapers/kanaria.png")
hl.env("XCURSOR_THEME", "BreezeX-RosePineDawn")
hl.env("XCURSOR_SIZE", 48)
hl.env("HYPRCURSOR_THEME", "rose-pine-dawn-hyprcursor")
hl.env("HYPRCURSOR_SIZE", 48)
hl.env("GTK_THEME", "RosePine")

return THEME
