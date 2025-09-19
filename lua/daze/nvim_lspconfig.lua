vim.lsp.config("ccls", {
	init_options = {
		compilationDatabaseDirectory = "build",
		index = {
			threads = 2,
			trackDependencies = true,
		},
		clang = {
			excludeArgs = { "-frounding-math" },
		},
	},
})
vim.lsp.enable("ccls")
vim.lsp.enable("dartls")
vim.lsp.enable("systemd_ls")
