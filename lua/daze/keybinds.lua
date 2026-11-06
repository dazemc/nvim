local keymap = vim.keymap.set
local buf = vim.lsp.buf
local bufopts = { noremap = true, silent = true }
local function map(mode, lhs, rhs, desc)
	keymap(mode, lhs, rhs, vim.tbl_extend("force", bufopts, { desc = desc or "" }))
end
local mappings = {
	n = {
		-- gd/gD/gr are owned by snacks pickers in lua/plugins/snacks.lua.
		{ "gi", buf.implementation, "Implementation" },
		{ "<leader>i", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "sed" },
		{
			"[",
			function()
				vim.diagnostic.jump({ count = -1, float = false })
			end,
		},
		{
			"]",
			function()
				vim.diagnostic.jump({ count = 1, float = false })
			end,
		},
		{
			"<leader>d",
			function()
				vim.diagnostic.setqflist({ open = true })
			end,
			"Diagnostics Pane",
		},
		{ "<leader>ca", buf.code_action },
		-- Directory view
		{ "-", vim.cmd.Ex },
		{ "<A-h>", "<C-w>h" },
		{ "<A-j>", "<C-w>j" },
		{ "<A-k>", "<C-w>k" },
		{ "<A-l>", "<C-w>l" },
		{ "<A-q>", "<C-w>q" },
		{ "<A-x>", ":split<CR>" },
		{ "<A-y>", ":vsplit<CR>" },
		{ "<leader>t", ":tabnew<CR>", "New Tab" },
		{ "<leader>tc", ":tabclose<CR>", "Close Tab" },
		{ "<A-n>", ":bnext<CR>", "Next Buffer" },
		{ "<A-p>", ":bprevious<CR>", "Previous Buffer" },
	},
	v = { { "J", ":m '>+1<CR>gv=gv" }, { "K", ":m '<-2<CR>gv=gv" } },
}
for mode, mode_mappings in pairs(mappings) do
	for _, mapping in ipairs(mode_mappings) do
		local key = mapping[1]
		local action = mapping[2]
		local desc = mapping[3]
		map(mode, key, action, desc)
	end
end
