return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local esp32 = require("esp32")
    opts.servers = opts.servers or {}
    opts.servers.clangd = esp32.lsp_config()
    return opts
  end,
  config = function()
    local esp32 = require('esp32')
    vim.lsp.config('clangd', esp32.lsp_config())
    vim.lsp.enable('clangd')
  end,
}
