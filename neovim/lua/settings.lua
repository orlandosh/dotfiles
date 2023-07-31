Set = vim.opt

vim.g.onedark_termcolors = 16
vim.g.rainbow_active = 1

-- gruvbox
Set.background = "dark"
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
vim.g.gruvbox_material_background = "soft"

vim.cmd([[
	syntax on
	colorscheme gruvbox-material
	setlocal spell spelllang=en_ca
]])

Set.showmode = false
Set.completeopt = { "menu", "menuone", "noselect" }
Set.number = true
Set.relativenumber = true
Set.termguicolors = true
Set.modifiable = true
Set.ignorecase = true
Set.smartcase = true
Set.spell = true
Set.cmdheight = 0

Set.foldmethod = "expr"
Set.foldexpr = "nvim_treesitter#foldexpr()"
Set.foldenable = false
