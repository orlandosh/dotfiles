-- format on save
local dir = require("utils").get_dir()

if not dir:find("apicbase") then
	vim.api.nvim_create_autocmd({ "BufWritePre" }, {
		pattern = { "*.py", "*.lua" },
		callback = function()
			vim.lsp.buf.formatting_sync(nil, 1000)
		end,
	})
end

-- lint on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.py" },
	callback = function()
		require("plugins.lint").lint.try_lint()
	end,
})
