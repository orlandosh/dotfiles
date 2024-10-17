return {
	"Pocco81/auto-save.nvim",
	event = "VeryLazy",
	config = function()
		require("auto-save").setup({
			enabled = true,
			write_all_buffers = true,
			condition = function(buf)
				local fn = vim.fn
				local utils = require("auto-save.utils.data")
				if
					fn.getbufvar(buf, "&modifiable") == 1
					and utils.not_in(fn.getbufvar(buf, "&filetype"), { "octo" })
				then
					return true -- met condition(s), can save
				end
				return false -- can't save
			end,
		})
	end,
}
