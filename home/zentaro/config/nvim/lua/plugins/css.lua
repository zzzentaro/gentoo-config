return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				jsonls = {
					filetypes = { "css" },
				},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				css = { "prettier" },
			},
		},
	},
}
