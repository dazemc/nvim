return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "gruvbox",
			icons_enabled = true,
			component_separators = "",
			section_separators = "",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff" },
			lualine_c = { { "filename", path = 1 } },
			lualine_x = { "diagnostics" },
			lualine_y = { "filetype", "lsp_status" },
			lualine_z = { "location" },
		},
		tabline = {
			lualine_a = { "buffers" },
			lualine_z = { "tabs" },
		},
	},
}
