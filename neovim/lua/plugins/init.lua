require("plugins._packer")
require("Comment").setup()
require("gitsigns").setup()

local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "%.po", "assets" },
		mappings = {
			n = { ["dd"] = actions.delete_buffer },
		},
	},
})

require("plugins")
require("lsp_stuff")
require("lint_stuff")
require("trouble_stuff")
require("autosave_stuff")
require("nvim-autopairs").setup({})
require("feline").setup({})
require("indent_blankline_cfg")
require("colorizer").setup()
require("sessions")