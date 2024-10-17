return {
	"hrsh7th/nvim-cmp",
	event = "VeryLazy",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"neovim/nvim-lspconfig",
		{
			"neovim/nvim-lspconfig",
			dependencies = {

				"onsails/lspkind-nvim",
				{
					"kosayoda/nvim-lightbulb",
					config = function()
						require("nvim-lightbulb").setup({
							autocmd = { enabled = true },
						})
					end,
				},
			},
		},
		{
			"hrsh7th/cmp-vsnip",
			dependencies = {
				"hrsh7th/vim-vsnip",
			},
		},
	},
}
