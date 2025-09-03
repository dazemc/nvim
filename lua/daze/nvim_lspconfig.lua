require("lspconfig").ccls.setup({
	cmd = { "ccls" }, -- system binary
	root_dir = require("lspconfig.util").root_pattern("platformio.ini", ".git", ".ccls"),
	init_options = {
		index = { threads = 2, trackDependencies = true },
	},
})

require("lspconfig").dartls.setup({
	cmd = { "dart", "language-server", "--protocol=lsp" },
	filetypes = { "dart" },
	init_options = {
		closingLabels = true,
		flutterOutline = true,
		onlyAnalyzeProjectsWithOpenFiles = true,
		outline = true,
		suggestFromUnimportedLibraries = true,
	},
	-- root_dir = root_pattern("pubspec.yaml"),
	settings = {
		dart = {
			completeFunctionCalls = true,
			showTodos = true,
		},
	},
	on_attach = function(client, bufnr)
		-- Only enable if the server supports formatting
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format()
				end,
			})
		end
	end,
})
