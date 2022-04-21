local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "%.po", "assets" },
		mappings = {
			n = { ["dd"] = actions.delete_buffer },
		},
	},
})
