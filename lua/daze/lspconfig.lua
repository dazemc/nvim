-- helpers
local function exe(name)
	return vim.fn.executable(name) == 1
end

-- Detect ESP32 project
local is_esp32 = vim.fn.findfile("build.clang", ".;**") ~= "" or vim.fn.finddir("build.clang", ".;**") ~= ""

-- Clangd
if is_esp32 then
	local ok, esp32 = pcall(require, "esp32")
	if ok then
		vim.lsp.config("clangd", esp32.lsp_config())
	end
else
	vim.lsp.config("clangd", {
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
	})
end
vim.lsp.enable("clangd")

-- Dart
if exe("dart") then
	vim.lsp.enable("dartls")
end

-- CCLS
if exe("ccls") then
	vim.lsp.config("ccls", {
		init_options = {
			cache = { directory = ".ccls-cache" },
			compilationDatabaseDirectory = "build",
			index = { threads = 2, trackDependencies = true },
			clang = { excludeArgs = { "-frounding-math" } },
		},
	})
	vim.lsp.enable("ccls")
end

-- Systemd
if exe("systemd-lsp") then
	vim.lsp.enable("systemd_ls")
end

-- Lemminx
if exe("lemminx") then
	vim.lsp.config("lemminx", {
		filetypes = { "html", "htm", "xhtml", "xml", "xsd", "xsl", "xslt", "svg" },
		settings = {
			xml = {
				catalogs = {},
				format = { enabled = true, splitAttributes = false },
			},
			html = {
				format = { enabled = true, templating = true },
			},
		},
	})
	vim.lsp.enable("lemminx")
end

-- Hyprlang
if exe("hyprls") then
	vim.lsp.config("hyprlang", {
		cmd = { "hyprls" },
		filetypes = { "hyprlang" },
		root_dir = function(fname)
			return vim.fs.root(fname, { ".git" }) or vim.fn.getcwd()
		end,
		settings = {
			hyprls = {
				preferIgnoreFile = true,
				ignore = { "hyprlock.conf", "hypridle.conf" },
			},
		},
	})
	vim.lsp.enable("hyprlang")
end

-- Lua LS (lua + hyprlang)
if exe("lua-language-server") then
	vim.lsp.config("lua_ls", {
		filetypes = { "lua", "hyprlang" },
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
