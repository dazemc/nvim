vim.lsp.config("ccls", {
	init_options = {
		cache = {
			directory = ".ccls-cache",
		},
		compilationDatabaseDirectory = "build",
		index = {
			threads = 2,
			trackDependencies = true,
		},
		clang = {
			excludeArgs = { "-frounding-math" },
		},
	},
})
vim.lsp.enable("ccls")
vim.lsp.enable("dartls")
vim.lsp.enable("systemd_ls")
vim.lsp.buf.code_action({
	apply = true,
})

local function dart_fix_all()
	local params = {
		command = "dart.edit.fixAll",
		arguments = {
			{
				path = vim.api.nvim_buf_get_name(0),
			},
		},
		title = "",
	}

	local clients = vim.lsp.get_clients({ name = "dartls" })
	if #clients == 0 then
		vim.notify("No dartls client found", vim.log.levels.ERROR)
		return
	end
	local client = clients[1]
	client:exec_cmd(params)
	params.command = "dart.edit.organizeImports"
	client:exec_cmd(params)
	params.command = "dart.edit.sortMembers"
	client:exec_cmd(params)

	vim.notify("Applied all Dart fixes", vim.log.levels.INFO)
end

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.dart",
	callback = dart_fix_all,
})

vim.api.nvim_create_user_command("LspShowCodeActions", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local params = vim.lsp.util.make_range_params()

	params.context = {
		triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
		diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
	}

	vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(error, results, context, config)
		if error then
			print("Error getting code actions:", error)
			return
		end
		print(vim.inspect(results))
	end)
end, {})
