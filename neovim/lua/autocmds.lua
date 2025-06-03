-- lint on save
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	pattern = { "*.py", "*.sql", "*.svelte", "*.ts" },
-- 	callback = function()
-- 		require("lint").try_lint()
-- 	end,
-- })

-- TODO: remove trailing whitespace

vim.api.nvim_create_autocmd({ "CmdLineEnter" }, {
	pattern = { ":" },
	callback = function()
		Set.smartcase = false
	end,
})

vim.api.nvim_create_autocmd({ "CmdLineLeave" }, {
	pattern = { ":" },
	callback = function()
		Set.smartcase = true
	end,
})

-- 1. Create or reuse an augroup so the rules are easy to find/clear later
local two_space_indent = vim.api.nvim_create_augroup("TwoSpaceIndent", { clear = true })

-- 2. Apply the settings whenever one of the chosen filetypes is detected
vim.api.nvim_create_autocmd("FileType", {
  group = two_space_indent,
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" }, -- ts, tsx, js, jsx
  callback = function()
    -- buffer‑local options (only affect the current buffer)
    vim.opt_local.tabstop     = 2  -- how many columns a literal <Tab> counts for
    vim.opt_local.shiftwidth  = 2  -- how far >> and << shift, and what “auto‑indent” uses
    vim.opt_local.softtabstop = 2  -- how many columns <Tab>/<BS> insert/delete in insert mode
    vim.opt_local.expandtab   = true -- convert real <Tab> presses into spaces
  end,
})
