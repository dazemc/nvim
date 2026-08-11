return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-context",
			opts = {
				max_lines = 4,
				multiline_threshold = 2,
			},
		},
	},
	config = function()
		vim.filetype.add({
			pattern = {
				[".*/hypr/.*%.conf"] = "hyprlang",
				[".*/hypr/.*%.lua"] = "hyprlang",
			},
		})

		local ts = require("nvim-treesitter")

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyDone",
			once = true,
			callback = function()
				ts.install({
					"bash",
					"comment",
					"css",
					"dart",
					"diff",
					"fish",
					"git_config",
					"git_rebase",
					"gitcommit",
					"gitignore",
					"html",
					"javascript",
					"json",
					"latex",
					"lua",
					"luadoc",
					"make",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"regex",
					"scss",
					"svelte",
					"toml",
					"tsx",
					"typescript",
					"typst",
					"vim",
					"vimdoc",
					"vue",
					"xml",
					"yaml",
					"hyprlang",
				})
			end,
		})

		local ignore = {
			checkhealth = true,
			lazy = true,
			mason = true,
			snacks_dashboard = true,
			snacks_notif = true,
			snacks_win = true,
		}

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
			callback = function(ev)
				if ignore[ev.match] then
					return
				end
				local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
				pcall(vim.treesitter.start, ev.buf, lang)
				vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				ts.install({ lang })
			end,
		})
	end,
}
