return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	opts = {
		signs = {
			add = { text = "" },
			change = { text = "" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "" },
		},
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
		},
		word_diff = true, -- "mini-diff" effect
	},
}
