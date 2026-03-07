local lspconfig = vim.lsp.config

-- Dart LSP
if vim.fn.executable("dart") == 1 then
	vim.lsp.enable("dartls")
end

-- CCLS
if vim.fn.executable("ccls") == 1 then
	vim.lsp.enable("ccls")
	lspconfig("ccls", {
		init_options = {
			cache = { directory = ".ccls-cache" },
			compilationDatabaseDirectory = "build",
			index = { threads = 2, trackDependencies = true },
			clang = { excludeArgs = { "-frounding-math" } },
		},
	})
end

-- Systemd LSP
if vim.fn.executable("systemd-lsp") == 1 then
	vim.lsp.enable("systemd_ls")
end

-- Lemminx (XML/HTML)
if vim.fn.executable("lemminx") == 1 then
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
end
