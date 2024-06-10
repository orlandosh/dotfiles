-- important presets, must come before plugins
vim.keymap.set("n", "<SPACE>", "<Nop>", { desc = "Disable space" })
vim.g.mapleader = " " -- set leader to space

vim.keymap.set("n", "<leader>re", "<C-l>", { desc = "Redraw screen" })
vim.keymap.set("n", "<leader>W", "<cmd>wa<cr>", { desc = "Write all" })

-- open neotree
vim.keymap.set("n", "<leader>b", "<cmd>Neotree toggle position=right<cr>", { desc = "Toggle Neotree" })

-- vim.keymap.set("n", "<leader>||||sv", "<cmd>source $MYVIMRC<cr>") -- unused because it doesn't work

vim.keymap.set("n", "<leader>T", "<cmd>Telescope planets<cr>", { desc = "Telescope planets" })
vim.keymap.set("n", "<leader>tb", "<cmd>Telescope builtin<cr>", { desc = "Telescope builtin" })
vim.keymap.set("n", "<leader>tl", "<cmd>Telescope reloader<cr>", { desc = "Telescope reloader" })
vim.keymap.set("n", "<leader>tc", "<cmd>Telescope colorscheme enable_preview=true<cr>")
vim.keymap.set("n", "<leader>tk", "<cmd>Telescope keymaps<cr>")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", function()
	require("telescope.builtin").live_grep({})
end)
vim.keymap.set("n", "<leader>fb", function()
	require("telescope.builtin").buffers({ show_all_buffers = true })
end)
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_workspace_symbols<cr>")
vim.keymap.set(
	"n",
	"<leader>fD",
	"<cmd>Telescope lsp_document_symbols symbols=struct,function,class,module,object,method,enum,constant<cr>"
)
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope lsp_document_symbols<cr>")
vim.keymap.set("n", "<leader>tr", "<cmd>Telescope diagnostics<cr>") -- from trouble
vim.keymap.set("n", "<leader>ts", "<cmd>Telescope treesitter<cr>")
vim.keymap.set("n", "<leader>sc", "<cmd>Telescope spell_suggest<cr>")
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>")
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope pickers<cr>")
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>")

vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>")

-- isort current file
vim.keymap.set("n", "<leader>is", "<cmd>!isort --profile black %<cr>", {
	desc = "Sort imports with isort",
})

vim.keymap.set("n", "<leader>bf", "<cmd>!black % && isort --profile black % && black %<cr>", {
	desc = "Format current file with black",
})

-- Neotest
vim.keymap.set("n", "<leader>tt", "<cmd>Neotest run<cr>")
vim.keymap.set("n", "<leader>tf", "<cmd>Neotest summary<cr>")
vim.keymap.set("n", "<leader>to", "<cmd>Neotest output-panel<cr>")

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

-- navbuddy & outline
vim.keymap.set("n", "<leader>no", "<cmd>Navbuddy<cr>")
vim.keymap.set("n", "<leader>so", "<cmd>SymbolsOutline<cr>")

-- spectre
vim.keymap.set("n", "<leader>st", '<cmd>lua require("spectre").toggle()<CR>', {
	desc = "Toggle Spectre",
})
vim.keymap.set("n", "<leader>se", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word",
})
vim.keymap.set("v", "<leader>se", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word",
})
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file",
})

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
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<cr>")
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<cr>")
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<cr>")

vim.keymap.set("n", "<leader>A", "<cmd>split<cr>")
vim.keymap.set("n", "<leader>S", "<cmd>vsplit<cr>")

vim.keymap.set("n", "<leader>xc", "<cmd>close<cr>")

-- quit vim
vim.keymap.set("n", "ZZ", "<cmd>wqa<cr>")

-- toggle cmdheight
vim.keymap.set("n", "<leader>ch", function()
	if Set.cmdheight._value == 0 then
		Set.cmdheight = 1
	else
		Set.cmdheight = 0
	end
end)

-- toggle relative lines to reduce latency
vim.keymap.set("n", "<leader>rl", function()
	if Set.relativenumber._value == true then
		Set.relativenumber = false
	else
		Set.relativenumber = true
	end
end)

-- Function to copy text to Kitty's clipboard
local function copy_to_kitty_clipboard(lines)
	local text = table.concat(lines, "\n")
	local handle = io.popen("kitty +kitten clipboard", "w")
	handle:write(text)
	handle:close()
end

-- Function to paste text from Kitty's clipboard
local function paste_from_kitty_clipboard()
	local handle = io.popen('kitty +kitten clipboard --get-clipboard --mime "text/plain"')
	local result = handle:read("*a")
	handle:close()
	return vim.fn.split(result, "\n")
end

-- Define custom clipboard integration
local clipboard = {
	name = "kitty-clipboard",
	copy = {
		["+"] = copy_to_kitty_clipboard,
		["*"] = copy_to_kitty_clipboard,
	},
	paste = {
		["+"] = paste_from_kitty_clipboard,
		["*"] = paste_from_kitty_clipboard,
	},
	cache_enabled = true,
}

-- Set clipboard option in Neovim
vim.opt.clipboard = clipboard

local M = {}
function M.lsp_keymaps(opts)
	return function(bufnr)
		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<A-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
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

		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fo", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
		vim.keymap.set("n", "<leader>fo", function()
			vim.lsp.buf.format({ timeout_ms = 1000 })
		end, vim.tbl_deep_extend("force", opts, { buffer = bufnr }))
	end
end

function M.cmp_keymaps(opts)
	vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

return M
