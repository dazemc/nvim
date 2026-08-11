return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"mason-org/mason.nvim",
		"nvimtools/none-ls.nvim",
	},
	opts = {
		ensure_installed = { "stylua", "prettier", "xmlformatter" },
	},
}
