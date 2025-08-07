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
