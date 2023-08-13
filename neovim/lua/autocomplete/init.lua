-- TODO: move this entire module out of here
local opts = { noremap = true, silent = true }
require("keymaps").cmp_keymaps(opts)
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

	if server == "sqlls" then
		lsp_opts.cmd = {
			"sql-language-server",
			"up",
			"--method",
			"stdio",
		}
		lsp_opts.root_dir = lspconfig.util.root_pattern(".git", ".sqllsrc")
	end

	if server == "rust_analyzer" then
		-- default settings
		lsp_opts.settings = {
			["rust-analyzer"] = {
				checkOnSave = true,
				check = {
					command = "clippy",
					extraArgs = { "--", "-A", "clippy::module_inception" },
				},
				workspace = {
					symbol = {
						search = {
							scope = "WorkspaceAndDependencies",
							limit = 1000000,
						},
					},
				},
			},
		}

		-- custom settings
		local current_dir = require("utils").get_dir()
		local settings_json = require("utils").get_json(current_dir .. "rust_analyzer_neovim.json")

		-- to merge custom settings, do it recursively
		local function merge(t1, t2)
			for k, v in pairs(t2) do
				if type(v) == "table" then
					if type(t1[k] or false) == "table" then
						merge(t1[k] or {}, t2[k] or {})
					else
						t1[k] = v
					end
				else
					t1[k] = v
				end
			end
		end

		merge(lsp_opts.settings["rust-analyzer"], settings_json)
	end

	lspconfig[server].setup(lsp_opts)
end

local settings = {
	rootMarkers = { ".git/" },
	lintDebounce = 1000,
	languages = {
		python = {
			{
				formatCommand = "black --quiet - | isort --stdout --profile black - | black --quiet -",
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
				formatCommand = "prettier --parser vue",
				formatStdin = true,
			},
		},
		cs = {
			{
				formatCommand = "dotnet-csharpier --write-stdout -",
				formatStdin = true,
			},
		},
		json = {
			{
				formatCommand = "prettier --parser json",
				formatStdin = true,
			},
		},
		html = {
			{
				formatCommand = "prettier --parser html",
				formatStdin = true,
			},
		},
		js = {
			{
				formatCommand = "prettier --parser babel",
				formatStdin = true,
			},
		},
		jsx = {
			{
				formatCommand = "prettier --parser babel",
				formatStdin = true,
			},
		},
		css = {
			{
				formatCommand = "prettier --parser css",
				formatStdin = true,
			},
		},
		scss = {
			{
				formatCommand = "prettier --parser scss",
				formatStdin = true,
			},
		},
	},
}

settings.lintDebounce = 1000

require("lspconfig").efm.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "/home/me/.local/share/nvim/lsp_servers/efm/efm-langserver" },
	settings = settings,
	filetypes = { "python", "lua", "vue", "cs", "rs", "sql", "json", "html", "js", "jsx", "css", "scss" },
	init_options = { documentFormatting = true, diagnostics = true },
})

require("lsp_signature").setup()
