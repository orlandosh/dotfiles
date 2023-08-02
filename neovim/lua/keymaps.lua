vim.keymap.set("n", "<SPACE>", "<Nop>")
vim.g.mapleader = " "

-- open neotree
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
vim.keymap.set("n", "<leader>sq", "<cmd>BufferCloseAllButCurrentOrPinned<cr>")

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

-- split movements
vim.keymap.set("n", "<A-h>", "<cmd>wincmd h<cr>")
vim.keymap.set("n", "<A-j>", "<cmd>wincmd j<cr>")
vim.keymap.set("n", "<A-k>", "<cmd>wincmd k<cr>")
vim.keymap.set("n", "<A-l>", "<cmd>wincmd l<cr>")

-- split vertically and horizontally
vim.keymap.set("n", "<leader>sv", "<cmd>split<cr>")
vim.keymap.set("n", "<leader>sh", "<cmd>vsplit<cr>")

-- toggle cmdheight
vim.keymap.set("n", "<leader>ch", function()
	if Set.cmdheight._value == 0 then
		Set.cmdheight = 1
	else
		Set.cmdheight = 0
	end
end)

local M = {}
function M.lsp_keymaps(opts)
	return function(bufnr)
		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)

		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<leader>wr",
			"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
			opts
		)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<leader>wl",
			"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
			opts
		)

		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fo", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
	end
end

function M.cmp_keymaps(opts)
	vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

return M
