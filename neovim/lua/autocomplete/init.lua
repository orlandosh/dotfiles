local opts = { noremap = true, silent = true }
require("autocomplete.keymaps")(opts)
local on_attach = require("autocomplete.on_attach")(opts)
local utils = require("utils")

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
require("autocomplete.cmp")

local bufdir = utils.get_dir()

local lspconfig = require("lspconfig")
local installed_servers = require("mason-lspconfig").get_installed_servers()

for _, server in pairs(installed_servers) do
	local lsp_opts = { on_attach = on_attach, capabilities = capabilities }

	if server == "pyright" then
		if string.find(bufdir, "apicbase") then
			lsp_opts.settings = {
				python = {
					analysis = {
						diagnosticMode = "openFilesOnly",
					},
				},
			}
		end
	end

	if server == "jedi_language_server" then
		lsp_opts.init_options = { workspace = { symbols = { maxSymbols = -1 } } }
	end

	if server == "omnisharp" then
		lsp_opts.cmd = {
			"/home/me/.local/share/nvim/mason/bin/omnisharp",
			"--languageserver",
			"--hostPID",
			tostring(vim.fn.getpid()),
		}
	end

	lspconfig[server].setup(lsp_opts)
end

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
		cs = {
			{
				formatCommand = "dotnet-csharpier --write-stdout -",
				formatStdin = true,
			},
		},
		rs = {
			{
				formatCommand = "rustfmt --emit=stdout",
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
	filetypes = { "python", "lua", "vue", "cs" },
	init_options = { documentFormatting = true, diagnostics = true },
})

require("lsp_signature").setup()
