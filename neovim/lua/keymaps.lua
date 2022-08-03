-- For LSP keymaps, go to lsp/keymaps.lua

vim.keymap.set("n", "<SPACE>", "<Nop>")
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>b", "<cmd>Neotree toggle<cr>")

vim.keymap.set("n", "<leader>sv", "<cmd>source $MYVIMRC<cr>")

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", "<leader>tw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
vim.keymap.set("n", "<leader>ts", "<cmd>Telescope treesitter<cr>")
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>")

vim.keymap.set("n", "<leader>tr", "<cmd>TroubleToggle<cr>")

vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>")

-- Clear highlighting on escape in normal mode
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><esc>")
vim.keymap.set("n", "<esc>^[", "<esc>^[")
