vim.loader.enable()
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,localoptions"

-- important presets, must come before plugins
vim.keymap.set("n", "<SPACE>", "<Nop>", { desc = "Disable space" })
vim.g.mapleader = " " -- set leader to space

require("settings")
require("plugin_loader")
