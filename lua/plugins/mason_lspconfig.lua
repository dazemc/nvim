return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		"mason-org/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	opts = {
		ensure_installed = { "lua_ls", "bashls", "systemd_lsp" },
		automatic_installation = true,
		-- Enable servers explicitly in daze/lspconfig.lua. Automatic enable
		-- would resurrect clangd, which duplicates ccls for C/C++.
		automatic_enable = false,
	},
}
