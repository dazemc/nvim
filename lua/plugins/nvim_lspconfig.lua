return {
	"neovim/nvim-lspconfig",
	lazy = false,
	opts = function(_, opts)
		opts.servers = opts.servers or {}

		-- Detect ESP32 project using build.clang marker
		local is_esp32 = vim.fn.findfile("build.clang", ".;**") ~= "" or vim.fn.finddir("build.clang", ".;**") ~= ""

		if is_esp32 then
			local esp32 = require("esp32")
			opts.servers.clangd = esp32.lsp_config()
		else
			-- Normal C/C++ projects
			opts.servers.clangd = {
				cmd = { "clangd" },
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_markers = {
					"compile_commands.json",
					"compile_flags.txt",
					".clangd",
					".git",
					"CMakeLists.txt",
					"meson.build",
				},
				single_file_support = true,
			}
		end

		return opts
	end,

	config = function()
		vim.lsp.enable("clangd")
	end,
}
