local set = vim.opt

vim.g.onedark_termcolors = 16
vim.g.rainbow_active = 1

vim.cmd([[
	syntax on
	colorscheme onedark
	highlight Comment gui=italic
	setlocal spell spelllang=en_ca
]])

set.showmode = false
set.completeopt = { "menu", "menuone", "noselect" }
set.number = true
set.relativenumber = true
set.termguicolors = true
set.modifiable = true
set.laststatus = 3
set.ignorecase = true
set.spell = true
