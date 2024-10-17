return {
	"folke/neodev.nvim",
	event = "VeryLazy",
	config = function()
		require("neodev").setup()
	end,
}
