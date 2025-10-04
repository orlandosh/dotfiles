Dir = require("utils").get_dir()
WorkKeyword = require("utils").WORK_KEYWORD

Set = vim.opt
G = vim.g

G.rainbow_active = 1

Set.background = "dark"
-- gruvbox
G.gruvbox_material_enable_italic = 1
G.gruvbox_material_diagnostic_virtual_text = "colored"
G.gruvbox_material_background = "soft"

-- everforest
G.everforest_enable_italic = 1
G.everforest_diagnostic_virtual_text = "colored"
G.everforest_background = "medium"

vim.cmd([[
	syntax on
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
Set.shiftwidth = 4
Set.smarttab = true
Set.tabstop = 4
Set.softtabstop = 4
Set.expandtab = true
Set.pumheight = 10
Set.mouse = ""

Set.foldmethod = "expr"
Set.foldexpr = "nvim_treesitter#foldexpr()"
Set.foldenable = false

-- gitblame
G.gitblame_message_template = "<author> • <date> #<sha>"
G.gitblame_date_format = "%r"
G.gitblame_display_virtual_text = 0
G.gitblame_enabled = 0 -- disabled by default

if vim.g.neovide then
	G.neovide_input_macos_alt_is_meta = true
	Set.guifont = "MonoLisa Neovide,Symbols Nerd Font Mono:h15:b:#h-none"
	G.neovide_cursor_vfx_mode = "railgun"
	G.neovide_refresh_rate = 60
	G.terminal_color_0 = "#504945"
	G.terminal_color_1 = "#ea6962"
	G.terminal_color_2 = "#a9b665"
	G.terminal_color_3 = "#d8a657"
	G.terminal_color_4 = "#7daea3"
	G.terminal_color_5 = "#d3869b"
	G.terminal_color_6 = "#89b482"
	G.terminal_color_7 = "#ebdbb2"
	G.terminal_color_8 = "#665c54"
	G.terminal_color_9 = "#ea6962"
	G.terminal_color_10 = "#a9b665"
	G.terminal_color_11 = "#d8a657"
	G.terminal_color_12 = "#7daea3"
	G.terminal_color_13 = "#d3869b"
	G.terminal_color_14 = "#89b482"
	G.terminal_color_15 = "#a89984"
	vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
	vim.keymap.set("v", "<D-c>", '"+y') -- Copy
	vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

-- enable inlay hint
vim.lsp.inlay_hint.enable(true)

G.db_ui_force_echo_notifications = 1
G.db_ui_use_nvim_notify = 1
