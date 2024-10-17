return {
	"catppuccin/nvim",
	event = "VeryLazy",
	config = function()
		require("catppuccin").setup({
			background = {
				light = "latte",
				dark = "frappe",
			},

			term_colors = true,
			default_integrations = true,
			integrations = {
				notify = true,
				noice = true,
				barbar = true,
				navic = { enabled = true },
				neotest = true,
				neotree = true,
				neogit = true,
				telescope = true,
				cmp = true,
				octo = true,
				indent_blankline = { enabled = true },
				illuminate = { enabled = true, lsp = false },
				native_lsp = {
					enabled = true,

					inlay_hints = {
						background = false,
					},
				},
			},
		})
	end,
}
