-- format on save
local dir = require("utils").get_dir()

if dir == nil then
	return
end

if not dir:find("apicbase") then
	vim.api.nvim_create_autocmd({ "BufWritePre" }, {
		pattern = { "*.py", "*.lua" },
		callback = function()
			local v = vim.fn.winsaveview()
			vim.lsp.buf.format({ timeout_ms = 1000 })
			vim.fn.winrestview(v)
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

-- TODO: remove trailing whitespace
