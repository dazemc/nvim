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
			local esp32 = require("esp32")

			mason_lspconfig.setup({
				ensure_installed = { "lua_ls", "bashls" },
				automatic_installation = true,
				automatic_setup = false,
			})
			lspconfig.clangd.setup(esp32.lsp_config())

			-- lspconfig.clangd.setup(
			-- 	vim.tbl_extend(
			-- 		"force",
			-- 		esp32.lsp_config(),
			-- 		{ capabilities = vim.lsp.protocol.make_client_capabilities() }
			-- 	)
			-- )
		end,
	},
}
