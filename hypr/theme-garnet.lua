-- source: rosepinetheme.com

local base = 0x191724
local surface = 0x1f1d2e
local overlay = 0x26233a
local muted = 0x6e6a86
local subtle = 0x908caa
local text = 0xe0def4
local love = 0xeb6f92
local gold = 0xf6c177
local rose = 0xebbcba
local pine = 0x31748f
local foam = 0x9ccfd8
local iris = 0xc4a7e7
local highlightLow = 0x21202e
local highlightMed = 0x403d52
local highlightHigh = 0x524f67

local THEME = {
	primary = love,
	primaryAlpha = "eb6f92",
	secondary = gold,
	tertiary = iris,
}

hl.env("XCURSOR_THEME", "BreezeX-RosePineDawn")
hl.env("XCURSOR_SIZE", 48)
hl.env("HYPRCURSOR_THEME", "rose-pine-dawn-hyprcursor")
hl.env("HYPRCURSOR_SIZE", 48)
hl.env("GTK_THEME", "RosePine")

return THEME
