local lspconfig = vim.lsp.config
vim.lsp.enable("dartls")
vim.lsp.enable("ccls")
vim.lsp.enable("systemd_ls")

-- CCLS
lspconfig("ccls", {
	init_options = {
		cache = { directory = ".ccls-cache" },
		compilationDatabaseDirectory = "build",
		index = { threads = 2, trackDependencies = true },
		clang = { excludeArgs = { "-frounding-math" } },
	},
})

-- Lemminx (XML/HTML)
lspconfig("lemminx", {
	filetypes = { "html", "htm", "xhtml", "xml", "xsd", "xsl", "xslt", "svg" },
	settings = {
		xml = {
			catalogs = {},
			format = { enabled = true, splitAttributes = false },
		},
		html = {
			format = { enabled = true, templating = true },
		},
	},
})
