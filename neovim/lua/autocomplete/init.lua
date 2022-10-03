local opts = { noremap = true, silent = true }
require("autocomplete.keymaps")(opts)
local on_attach = require("autocomplete.on_attach")(opts)
local utils = require("utils")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
require("autocomplete.cmp")

local bufdir = utils.get_dir()

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local lsp_opts = { on_attach = on_attach, capabilities = capabilities }

	if server.name == "pyright" then
		if string.find(bufdir, "apicbase") then
			lsp_opts.settings = { python = { analysis = {
				diagnosticMode = "openFilesOnly",
			} } }
		end
	end

	if server.name == "jedi_language_server" then
		lsp_opts.init_options = { workspace = { symbols = { maxSymbols = -1 } } }
	end

	if server.name == "efm" then
		return
	end

	if server.name == "sumneko_lua" then
		lsp_opts.settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				runtime = { version = "LuaJIT" },
				telemetry = {
					enable = false,
				},
			},
		}
		lsp_opts.capabilities = { document_formatting = false, document_range_formatting = false }
		lsp_opts.on_attach = function(client, bufnr)
			on_attach(client, bufnr)

			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end
	end

	server:setup(lsp_opts)
end)

local settings = {
	rootMarkers = { ".git/" },
	lintDebounce = 1000,
	languages = {
		python = {
			{
				formatCommand = "isort --stdout --profile black -",
				formatStdin = true,
			},
		},
		lua = {
			{
				formatCommand = "stylua -",
				formatStdin = true,
			},
		},
		vue = {
			{
				formatCommand = "prettier ${INPUT}",
				formatStdin = true,
			},
		},
	},
}

local p8ln = vim.env.MYVIMRC
p8ln = p8ln:gsub("%init.lua", "p8ln")
if string.find(bufdir, "apicbase") then
else
	table.insert(settings.languages.python, {
		formatCommand = "black --quiet -",
		formatStdin = true,
	})
end

settings.lintDebounce = 1000

require("lspconfig").efm.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/home/me/.local/share/nvim/lsp_servers/efm/efm-langserver" },
	settings = settings,
	filetypes = { "python", "lua", "vue" },
	init_options = { documentFormatting = true, diagnostics = true },
})

require("lsp_signature").setup()
