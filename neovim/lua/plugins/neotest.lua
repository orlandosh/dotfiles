return {
	"nvim-neotest/neotest",
	ft = { "python" },
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-neotest/neotest-python",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("neotest").setup({
			summary = {
				follow = false,
			},
			adapters = {
				require("neotest-python")({
					args = { "--keepdb" },
					dap = { justMyCode = false },
					runner = "django",
				}),
			},
		})
	end,
}
