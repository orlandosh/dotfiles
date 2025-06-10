return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate", -- :MasonUpdate updates registry contents
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "basedpyright", "efm", "lua_ls", "rust_analyzer", "ts_ls" },
			automatic_installation = { exclude = { "clangd" } },
			automatic_enable = false,
		})
	end,
	event = "VeryLazy",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
}
