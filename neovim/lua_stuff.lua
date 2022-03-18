dofile('/home/me/.config/nvim/lsp.lua')
dofile('/home/me/.config/nvim/lint.lua')
dofile('/home/me/.config/nvim/trouble.lua')
dofile('/home/me/.config/nvim/autosave.lua')
require('Comment').setup()
require('gitsigns').setup()
require('telescope').setup{defaults = { file_ignore_patterns = {"%.po"} }}
