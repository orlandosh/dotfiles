local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "%.po", "assets" },
		mappings = {
			n = { ["dd"] = actions.delete_buffer },
		},
		cache_picker = {
			num_pickers = 100,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

-- TODO: customize appearance
require("telescope").load_extension("fzf")
