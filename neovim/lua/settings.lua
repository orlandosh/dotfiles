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
vim.keymap.set("n", "<leader>tr", "<cmd>TroubleToggle<cr>")

-- Clear highlighting on escape in normal mode
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><esc>")
vim.keymap.set("n", "<esc>^[", "<esc>^[")

-- format on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.py", "*.lua" },
	callback = function()
		vim.lsp.buf.formatting_sync(nil, 1000)
	end,
})

-- lint on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.py" },
	callback = function()
		require("lint").try_lint()
	end,
})
