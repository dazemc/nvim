vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.list = true
vim.opt.listchars = "eol:.,tab:>-,trail:~,extends:>,precedes:<"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes:1"
vim.opt.scrolloff = 40
vim.opt.showcmd = true

vim.opt.swapfile = false
vim.opt.backup = false
local undodir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(undodir, "p")
vim.opt.undodir = undodir
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"

-- OSC 52 is a copy-only transport; terminals do not allow reading the
-- clipboard back. Paste through wl-paste on the local Wayland session so
-- p/P from + and * actually return text.
local function wayland_paste(primary)
	if vim.fn.executable("wl-paste") == 0 then
		return { {}, "v" }
	end
	local cmd = { "wl-paste", "--no-newline" }
	if primary then
		table.insert(cmd, 2, "--primary")
	end
	local lines = vim.fn.systemlist(cmd)
	if vim.v.shell_error ~= 0 then
		return { {}, "v" }
	end
	return { lines, "v" }
end

vim.g.clipboard = {
	name = "OSC 52 copy / Wayland paste",
	copy = {
		["+"] = function(lines, _)
			require("vim.ui.clipboard.osc52").copy("+")(lines)
		end,
		["*"] = function(lines, _)
			require("vim.ui.clipboard.osc52").copy("*")(lines)
		end,
	},
	paste = {
		["+"] = function()
			return wayland_paste(false)
		end,
		["*"] = function()
			return wayland_paste(true)
		end,
	},
}

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.showmode = false

-- No automatic comment insertion; use an augroup so reloads do not stack it.
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("UserFormatOptions", { clear = true }),
	pattern = "*",
	command = "setlocal formatoptions-=ro",
})

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlights text when yanking",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
