return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				qml = { "qmlformat" },
			},
			formatters = {
				qmlformat = {
					command = "/usr/lib64/qt6/bin/qmlformat",
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				qmlls = {
					cmd = { "/usr/bin/qmlls6" },
					filetypes = { "qml" },
				},
			},
		},
	},
}
