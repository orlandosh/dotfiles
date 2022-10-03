local set = vim.opt

vim.g.onedark_termcolors = 16
vim.g.rainbow_active = 1

-- gruvbox
set.background = "dark"
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
vim.g.gruvbox_material_background = "soft"

vim.cmd([[
	syntax on
	colorscheme gruvbox-material
	setlocal spell spelllang=en_ca
]])

set.showmode = false
set.completeopt = { "menu", "menuone", "noselect" }
set.number = true
set.relativenumber = true
set.termguicolors = true
set.modifiable = true
set.laststatus = 3
set.smartcase = true
set.spell = true
