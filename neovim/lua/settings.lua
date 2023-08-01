local dir = require("utils").get_dir()

Set = vim.opt
G = vim.g

G.onedark_termcolors = 16
G.rainbow_active = 1

-- gruvbox
Set.background = "dark"
G.gruvbox_material_enable_italic = 1
G.gruvbox_material_diagnostic_virtual_text = "colored"
G.gruvbox_material_background = "soft"

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

-- gitblame
G.gitblame_message_template = "<author> • <date> #<sha>"
G.gitblame_date_format = "%r"
G.gitblame_display_virtual_text = 0
if not dir:find("apicbase") then
	G.gitblame_enabled = 0
end
