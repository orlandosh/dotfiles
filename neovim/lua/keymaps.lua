-- For LSP keymaps, go to lsp/keymaps.lua

vim.keymap.set("n", "<SPACE>", "<Nop>")
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>b", "<cmd>Neotree toggle position=right<cr>")

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

-- barbar
vim.keymap.set("n", "<A-,>", "<cmd>BufferPrevious<cr>")
vim.keymap.set("n", "<A-.>", "<cmd>BufferNext<cr>")

vim.keymap.set("n", "<A-<>", "<cmd>BufferMovePrevious<cr>")
vim.keymap.set("n", "<A->>", "<cmd>BufferMoveNext<cr>")

vim.keymap.set("n", "<A-1>", "<cmd>BufferGoto 1<cr>")
vim.keymap.set("n", "<A-2>", "<cmd>BufferGoto 2<cr>")
vim.keymap.set("n", "<A-3>", "<cmd>BufferGoto 3<cr>")
vim.keymap.set("n", "<A-4>", "<cmd>BufferGoto 4<cr>")
vim.keymap.set("n", "<A-5>", "<cmd>BufferGoto 5<cr>")
vim.keymap.set("n", "<A-6>", "<cmd>BufferGoto 6<cr>")
vim.keymap.set("n", "<A-7>", "<cmd>BufferGoto 7<cr>")
vim.keymap.set("n", "<A-8>", "<cmd>BufferGoto 8<cr>")
vim.keymap.set("n", "<A-9>", "<cmd>BufferGoto 9<cr>")
vim.keymap.set("n", "<A-0>", "<cmd>BufferLast<cr>")

vim.keymap.set("n", "<A-p>", "<cmd>BufferPin<cr>")
vim.keymap.set("n", "<A-c>", "<cmd>BufferClose<cr>")
vim.keymap.set("n", "<A-o>", "<cmd>BufferPick<cr>")

vim.keymap.set("n", "<leader>sb", "<cmd>BufferOrderByBufferNumber<cr>")
vim.keymap.set("n", "<leader>sd", "<cmd>BufferOrderByDirectory<cr>")
vim.keymap.set("n", "<leader>sl", "<cmd>BufferOrderByLanguage<cr>")
vim.keymap.set("n", "<leader>sw", "<cmd>BufferOrderByWindowNumber<cr>")
vim.keymap.set("n", "<leader>qq", "<cmd>BufferCloseAllButCurrentOrPinned<cr>")

-- paste yanked text to insert mode
vim.keymap.set("i", "<A-v>", '<C-r>=substitute(getreg(), "\\n$", "", "")<CR>')

-- write last yanked content to ~/.nvim_yank
vim.keymap.set({ "n", "v" }, "<leader>vc", function()
	local yank = vim.fn.getreg('"0')
	if yank == nil or not yank or yank == "" then
		return
	end
	local yank_file = io.open(os.getenv("HOME") .. "/.nvim_yank", "w")
	if yank_file then
		yank_file:write(yank .. "\n")
		yank_file:close()
	end
end)

-- toggle gitblame
vim.keymap.set("n", "<leader>gb", "<cmd>GitBlameToggle<cr>")
