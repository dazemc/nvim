return {
	"neovim/nvim-lspconfig",
	lazy = false,
	config = function()
		-- Load after nvim-lspconfig has registered its server configs, so
		-- canonical names (hyprls, systemd_lsp) resolve at enable time.
		require("daze.lspconfig")
	end,
}
