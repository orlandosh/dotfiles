-- format on save
local dir = require("utils").get_dir()

-- lint on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.py", "*.sql", "*.svelte", "*.ts" },
	callback = function()
		require("plugins.lint").lint.try_lint()
	end,
})

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
