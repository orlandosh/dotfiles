return {
	"romgrk/barbar.nvim",
	event = "VeryLazy",
	config = function()
		require("bufferline").setup()
	end,
}
