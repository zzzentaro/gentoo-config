-- rose-pine.lua

local colorscheme = "rose-pine"
return {
	colorscheme .. "/neovim",
	name = colorscheme,
	lazy = false,

	config = function()
		vim.cmd.colorscheme(colorscheme)
	end,
}
