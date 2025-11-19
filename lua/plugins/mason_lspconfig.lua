return {
	{
		"mason-org/mason.nvim",
		config = true, -- just calls mason.setup()
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"systemd_ls",
					"lemminx",
				},
				automatic_installation = true,
			})
		end,
	},
}
