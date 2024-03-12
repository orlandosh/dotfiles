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

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyDone",
	callback = function()
		local ts_utils = require("nvim-treesitter.ts_utils")
		local suggestions = require("copilot.suggestion")
		vim.api.nvim_create_autocmd({ "CursorMoved" }, {
			pattern = { "*" },
			nested = true,
			callback = function()
				local current_node = ts_utils.get_node_at_cursor()
				local is_comment = false

				while current_node do
					if current_node:type() == "comment" then
						is_comment = true
						break
					end
					current_node = current_node:parent()
				end

				if is_comment then
					vim.b.copilot_suggestion_auto_trigger = false
					vim.b.copilot_suggestion_hidden = true
				else
					vim.b.copilot_suggestion_auto_trigger = true
					vim.b.copilot_suggestion_hidden = false
				end
			end,
		})
	end,
})
