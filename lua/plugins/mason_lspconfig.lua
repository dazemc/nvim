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
			local lspconfig = require("lspconfig")

			mason_lspconfig.setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"systemd_ls",
					"superhtml",
					"prettier",
					"lemminx",
					"xmlformatter",
					"stylelua",
				},
				automatic_installation = true,
			})
		end,
	},
}
