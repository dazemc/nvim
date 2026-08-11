return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- You can add your other which-key settings here
		plugins = { spelling = true },
		-- defaults are usually good
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
