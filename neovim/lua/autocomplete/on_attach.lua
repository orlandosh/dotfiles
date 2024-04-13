local navbuddy = require("nvim-navbuddy")
local navic = require("nvim-navic")

return function(opts)
	return function(client, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		require("keymaps").lsp_keymaps(opts)(bufnr)

		if client.server_capabilities.documentSymbolProvider and client.name ~= "jedi_language_server" then
			navbuddy.attach(client, bufnr)
			navic.attach(client, bufnr)
		end

		if client.name == "basedpyright" then
			client.server_capabilities.hoverProvider = false
		end

		if vim.lsp.inlay_hint then
			vim.lsp.inlay_hint.enable(bufnr, true)
		end

		if client.name == "jedi_language_server" then
			client.server_capabilities = {
				codeActionProvider = true,
				hoverProvider = true,
				textDocumentSync = {
					change = 2,
					openClose = true,
					save = {
						includeText = true,
					},
				},
				workspace = {
					workspaceFolders = {
						changeNotifications = true,
						supported = true,
					},
				},
			}
		end
	end
end
