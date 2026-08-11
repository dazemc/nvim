return {
	"kylechui/nvim-surround",
	version = "^3.0.0",
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({})
		local wk = require("which-key")
		wk.add({
			{ "<leader>s", group = "Surround", mode = { "n", "v" } },
			{ "ys", desc = "Add surrounding" },
			{ "yS", desc = "Add surrounding (new lines)" },
			{ "cs", desc = "Change surrounding" },
			{ "ds", desc = "Delete surrounding" },
			{ "yss", desc = "Surround current line" },
			{ "ySS", desc = "Surround current line (new lines)" },
			{ "S", mode = "v", desc = "Surround selection" },
			{ "gS", mode = "v", desc = "Surround selection (new lines)" },
		})
	end,
}
