return {
	"Aietes/esp32.nvim",
	name = "esp32.nvim",
	dependencies = {
		"folke/snacks.nvim",
	},
	opts = {
		build_dir = "build.clang",
	},
	config = function(_, opts)
		local esp32 = require("esp32")
		esp32.setup(opts)

		-- Setup tiny-inline-diagnostic manually for no apparent reason
		local tid = require("tiny-inline-diagnostic")
		tid.setup({
			highlight = "DiagnosticVirtualTextWarning", -- or Error/Info/Hint
		})
	end,

	keys = {
		{
			"<leader>eM",
			function()
				require("esp32").pick("monitor")
			end,
			desc = "ESP32: Pick & Monitor",
		},
		{
			"<leader>em",
			function()
				require("esp32").command("monitor")
			end,
			desc = "ESP32: Monitor",
		},
		{
			"<leader>eF",
			function()
				require("esp32").pick("flash")
			end,
			desc = "ESP32: Pick & Flash",
		},
		{
			"<leader>ef",
			function()
				require("esp32").command("flash")
			end,
			desc = "ESP32: Flash",
		},
		{
			"<leader>ec",
			function()
				require("esp32").command("menuconfig")
			end,
			desc = "ESP32: Configure",
		},
		{
			"<leader>eC",
			function()
				require("esp32").command("clean")
			end,
			desc = "ESP32: Clean",
		},
		{ "<leader>Rr", ":ESPReconfigure<CR>", desc = "ESP32: Reconfigure project" },
		{ "<leader>Ri", ":ESPInfo<CR>", desc = "ESP32: Project Info" },
	},
}
