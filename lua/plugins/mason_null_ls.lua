return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},
	config = function()
		require("mason-null-ls").setup({
			ensure_installed = { "stylua", "prettier", "xmlformatter" },
		})
		-- require("your.null-ls.config") -- require your null-ls config here (example below)
	end,
}
