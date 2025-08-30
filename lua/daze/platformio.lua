local pok, platformio = pcall(require, "platformio")
if pok then
	platformio.setup({
		lsp = "clangd",
		menu_key = "<leader>\\", -- replace this menu key  to your convenience
	})
end
