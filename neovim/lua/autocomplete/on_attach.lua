local navbuddy = require("nvim-navbuddy")
local navic = require("nvim-navic")

return function(opts)
	return function(client, bufnr)
		require("keymaps").lsp_keymaps(opts)(bufnr)

		if client.server_capabilities.documentSymbolProvider then
			navbuddy.attach(client, bufnr)

			if not (vim.b[bufnr].navic_client_id ~= nil and vim.b[bufnr].navic_client_name ~= client.name) then
				navic.attach(client, bufnr)
			end
		end

	end
end
