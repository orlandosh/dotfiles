return {
	"backdround/improved-search.nvim",
	event = "VeryLazy",
	config = function()
		local search = require("improved-search")
		-- Search next / previous.
		vim.keymap.set({ "n", "x", "o" }, "n", search.stable_next)
		vim.keymap.set({ "n", "x", "o" }, "N", search.stable_previous)

		-- Search current word without moving.
		vim.keymap.set("n", "!", search.current_word)

		-- Search selected text in visual mode
		vim.keymap.set("x", "!", search.in_place) -- search selection without moving
		vim.keymap.set("x", "*", search.forward) -- search selection forward
		vim.keymap.set("x", "#", search.backward) -- search selection backward

		-- Search by motion in place
		vim.keymap.set("n", "|", search.in_place)
		-- You can also use search.forward / search.backward for motion selection.
	end,
}
