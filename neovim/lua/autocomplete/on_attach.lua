local navbuddy = require("nvim-navbuddy")
local navic = require("nvim-navic")

return function(opts)
	return function(client, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		require("keymaps").lsp_keymaps(opts)(bufnr)
		require("lsp-inlayhints").on_attach(client, bufnr)

		if client.server_capabilities.documentSymbolProvider then
			navbuddy.attach(client, bufnr)
			navic.attach(client, bufnr)
		end
	end
end
