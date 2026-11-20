-- helpers
local function exe(name)
	return vim.fn.executable(name) == 1
end

-- Detect ESP32 project
-- local is_esp32 = vim.fn.findfile("build.clang", ".;**") ~= "" or vim.fn.finddir("build.clang", ".;**") ~= ""

-- Clangd
vim.lsp.enable("clangd", false)
-- if is_esp32 then
-- 	local ok, esp32 = pcall(require, "esp32")
-- 	if ok then
-- 		vim.lsp.config("clangd", esp32.lsp_config())
-- 	end
-- else
-- 	vim.lsp.config("clangd", {
-- 		cmd = { "clangd" },
-- 		filetypes = { "c", "cpp", "objc", "objcpp" },
-- 		root_markers = {
-- 			"compile_commands.json",
-- 			"compile_flags.txt",
-- 			".clangd",
-- 			".git",
-- 			"CMakeLists.txt",
-- 			"meson.build",
-- 		},
-- 		single_file_support = true,
-- 	})
-- end
-- vim.lsp.enable("clangd")

-- Dart is configured by flutter-tools.nvim; enabling dartls here as well
-- would attach a second client to every Dart buffer.

-- CCLS
if exe("ccls") then
	vim.lsp.config("ccls", {
		cmd = { "ccls" },
		filetypes = { "c", "cpp", "objc", "objcpp" },
		root_markers = {
			"compile_commands.json",
			".ccls",
			"CMakeLists.txt",
			".git",
		},
		single_file_support = true,
		init_options = {
			cache = {
				directory = ".ccls-cache",
			},
			compilationDatabaseDirectory = ".",
			index = {
				threads = 0,
			},
			clang = {
				extraArgs = {
					"-std=gnu++26",
					"--target=xtensa-esp32-elf",
					"-DARDUINO=10812",
					"-DARDUINO_ARCH_ESP32",
					"-D_GLIBCXX_HAVE_POSIX_SEMAPHORE",
					"-D_GLIBCXX_USE_POSIX_SEMAPHORE",

					-- force the correct libstdc++ paths
					"-isystem",
					"/home/daze/.espressif/tools/xtensa-esp-elf/esp-15.2.0_20251204/xtensa-esp-elf/xtensa-esp-elf/include/c++/15.2.0",
					"-isystem",
					"/home/daze/.espressif/tools/xtensa-esp-elf/esp-15.2.0_20251204/xtensa-esp-elf/xtensa-esp-elf/include/c++/15.2.0/xtensa-esp-elf/esp32",
					"-isystem",
					"/home/daze/.espressif/tools/xtensa-esp-elf/esp-15.2.0_20251204/xtensa-esp-elf/xtensa-esp-elf/include/c++/15.2.0/backward",
					"-isystem",
					"/home/daze/.espressif/tools/xtensa-esp-elf/esp-15.2.0_20251204/xtensa-esp-elf/lib/gcc/xtensa-esp-elf/15.2.0/include",
					"-isystem",
					"/home/daze/.espressif/tools/xtensa-esp-elf/esp-15.2.0_20251204/xtensa-esp-elf/lib/gcc/xtensa-esp-elf/15.2.0/include-fixed",
					"-isystem",
					"/home/daze/.espressif/tools/xtensa-esp-elf/esp-15.2.0_20251204/xtensa-esp-elf/xtensa-esp-elf/include",
				},
			},
		},
	})
	vim.lsp.enable("ccls")
end

-- Bash
if exe("bash-language-server") then
	vim.lsp.enable("bashls")
end

-- Systemd
if exe("systemd-lsp") then
	vim.lsp.enable("systemd_lsp")
end

-- Lemminx
if exe("lemminx") then
	vim.lsp.config("lemminx", {
		-- LemMinX is an XML language server; it does not speak HTML.
		filetypes = { "xhtml", "xml", "xsd", "xsl", "xslt", "svg" },
		settings = {
			xml = {
				catalogs = {},
				format = { enabled = true, splitAttributes = false },
			},
		},
	})
	vim.lsp.enable("lemminx")
end

-- Hyprlang (canonical nvim-lspconfig name is hyprls)
if exe("hyprls") then
	vim.lsp.config("hyprls", {
		cmd = { "hyprls", "--stdio" },
		filetypes = { "hyprlang" },
		root_dir = function(bufnr, on_dir)
			local file = vim.api.nvim_buf_get_name(bufnr)
			on_dir(vim.fs.root(file, { ".git" }) or vim.fn.getcwd())
		end,
		settings = {
			hyprls = {
				preferIgnoreFile = true,
				ignore = { "hyprlock.conf", "hypridle.conf" },
			},
		},
	})
	vim.lsp.enable("hyprls")
end

-- Lua LS
if exe("lua-language-server") then
	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = { "vim", "hl", "terminal", "fileManager", "menu" } },
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = { enable = false },
			},
		},
	})
	vim.lsp.enable("lua_ls")
end

-- Other mason-installed servers that were previously auto-enabled. Keep the
-- list explicit so clangd stays off and one filetype never gets two clients.
local function enable_if(bin, name)
	if exe(bin) then
		vim.lsp.enable(name)
	end
end

enable_if("basedpyright-langserver", "basedpyright")
enable_if("ruff", "ruff")
enable_if("cmake-language-server", "cmake")
enable_if("stylua", "stylua")
