-- format on save
local dir = require("utils").get_dir()

if dir ~= nil and not dir:find("apicbase") then
	vim.api.nvim_create_autocmd({ "BufWritePre" }, {
		pattern = { "*.py", "*.lua", "*.cs", "*.json", "*.rs", "*.toml", "*.sql" },
		callback = function()
			local v = vim.fn.winsaveview()
			vim.lsp.buf.format()
			vim.fn.winrestview(v)
		end,
	})
end

-- lint on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.py", "*.sql" },
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
