require("lspconfig").ccls.setup({
	cmd = { "ccls" }, -- system binary
	root_dir = require("lspconfig.util").root_pattern("platformio.ini", ".git", ".ccls"),
	init_options = {
		index = { threads = 2, trackDependencies = true },
	},
})
