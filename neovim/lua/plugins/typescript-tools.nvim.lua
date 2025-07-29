return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {},
	config = function()
		require("typescript-tools").setup({
			on_attach = function(client, bufnr)
				require("autocomplete.on_attach")({ noremap = true, silent = true })(client, bufnr)
			end,
		})
	end,
}
