vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

local uv = vim.uv or vim.loop
local lazyopts = {
	concurrency = (uv and uv.available_parallelism) and (uv.available_parallelism() * 2) or nil,
	-- root install directory
	root = vim.fn.stdpath("data") .. "/lazy",

	-- defaults for plugins
	defaults = {
		lazy = false, -- change to true to lazy-load everything by default
		version = nil,
		cond = nil,
	},

	-- plugin spec
	spec = { { import = "plugins" } },
	local_spec = true,
	lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",

	git = {
		log = { "-8" },
		timeout = 120,
		url_format = "https://github.com/%s.git",
		filter = true,
		throttle = { enabled = false, rate = 2, duration = 5000 },
		cooldown = 0,
	},

	-- dev options
	dev = {
		path = "~/projects",
		patterns = {},
		fallback = false,
	},

	-- install options
	install = {
		missing = true,
		colorscheme = { "moonfly" },
	},

	-- UI customization
	ui = {
		size = { width = 0.8, height = 0.8 },
		wrap = true,
		border = "none",
		backdrop = 60,
		title_pos = "center",
		pills = true,
		throttle = 1000 / 30,
		icons = {
			cmd = " ",
			config = "",
			debug = "● ",
			event = " ",
			favorite = " ",
			ft = " ",
			init = " ",
			import = " ",
			keys = " ",
			lazy = "󰒲 ",
			loaded = "●",
			not_loaded = "○",
			plugin = " ",
			runtime = " ",
			require = "󰢱 ",
			source = " ",
			start = " ",
			task = "✔ ",
			list = { "●", "➜", "★", "‒" },
		},
		custom_keys = {
			["<localleader>l"] = {
				function(plugin)
					require("lazy.util").float_term({ "lazygit", "log" }, { cwd = plugin.dir })
				end,
				desc = "Open lazygit log",
			},
			["<localleader>i"] = {
				function(plugin)
					vim.notify(vim.inspect(plugin), { title = "Inspect " .. plugin.name, lang = "lua" })
				end,
				desc = "Inspect Plugin",
			},
			["<localleader>t"] = {
				function(plugin)
					require("lazy.util").float_term(nil, { cwd = plugin.dir })
				end,
				desc = "Open terminal in plugin dir",
			},
		},
	},

	-- diff command
	diff = { cmd = "git" },

	-- checker
	checker = {
		enabled = false,
		notify = true,
		frequency = 3600,
		check_pinned = false,
	},

	-- auto reload config on changes
	change_detection = { enabled = true, notify = true },

	-- performance optimization
	performance = {
		cache = { enabled = true },
		reset_packpath = true,
		rtp = {
			reset = true,
			paths = {},
			disabled_plugins = {
				-- "gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				-- "tarPlugin",
				-- "tohtml",
				-- "tutor",
				-- "zipPlugin",
			},
		},
	},

	-- profiling
	profiling = { loader = false, require = false },

	-- readme generation
	readme = {
		enabled = true,
		root = vim.fn.stdpath("state") .. "/lazy/readme",
		files = { "README.md", "lua/**/README.md" },
		skip_if_doc_exists = true,
	},
}

require("lazy").setup(lazyopts)
