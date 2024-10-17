return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("todo-comments").setup({
			highlight = {
				before = "",
				keyword = "bg",
				after = "",
			},
		})
	end,
	event = "VeryLazy",
}
