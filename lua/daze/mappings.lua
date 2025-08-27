vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap

-- Directory view
keymap.set("n", "-", vim.cmd.Ex)

-- Move line up/down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- sed
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "sed" })

-- Diagnostics
vim.keymap.set("n", "[", function()
	vim.diagnostic.jump({ count = -1, float = false })
end)
vim.keymap.set("n", "]", function()
	vim.diagnostic.jump({ count = 1, float = false })
end)
vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.setqflist({ open = true })
end, { desc = "Diagnostics Pane" })

-- Panes
---- Movement
vim.keymap.set("n", "<A-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<A-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<A-l>", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<A-q>", "<C-w>q", { noremap = true, silent = true })
---- Split
vim.keymap.set("n", "<A-x>", ":split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-y>", ":vsplit<CR>", { noremap = true, silent = true })
