require("plugins")

vim.cmd("source ~/.config/nvim/vim_init.vim")

require("lsp_stuff")
require("lint_stuff")
require("trouble_stuff")
require("autosave_stuff")

require("Comment").setup()
require("gitsigns").setup()
require("telescope").setup({ defaults = { file_ignore_patterns = { "%.po", "assets" } } })
require("nvim-autopairs").setup({})
require("feline").setup({
	preset = "noicon",
})
require("indent_blankline_cfg")
require("colorizer").setup()
