-- TODO: move this entire module out of here
local opts = { noremap = true, silent = true }
require("keymaps").cmp_keymaps(opts)
local on_attach = require("autocomplete.on_attach")(opts)
local utils = require("utils")
local util = require("lspconfig/util")

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("autocomplete.cmp")

local bufdir = utils.get_dir()
local work_keyword = require("utils").work_keyword

local lspconfig = require("lspconfig")
local installed_servers = require("mason-lspconfig").get_installed_servers()

for _, server in pairs(installed_servers) do
	local lsp_opts = { on_attach = on_attach, capabilities = capabilities }

	if server == "pyright" then
		if string.find(bufdir, work_keyword) then
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

	if server == "pylsp" then
		lsp_opts.settings = {
			pylsp = {
				plugins = {
					jedi_completion = {
						fuzzy = true,
						eager = true,
						include_class_objects = true,
						include_function_objects = true,
						resolve_at_most = 500,
					},
					rope_autoimport = {
						enabled = true,
					},
					rope_completion = {
						enabled = true,
						eager = true,
					},
				},
			},
		}
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

	if server == "tsserver" then
		lsp_opts.settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		}
	end

	if server ~= "efm" then
		lspconfig[server].setup(lsp_opts)
	end
end

local settings = {
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
				formatCommand = "bunx prettier --parser vue",
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
				formatCommand = "bunx prettier --parser json",
				formatStdin = true,
			},
		},
		html = {
			{
				formatCommand = "bunx prettier --parser html",
				formatStdin = true,
			},
		},
		javascript = {
			{
				formatCommand = "bunx prettier --parser babel",
				formatStdin = true,
			},
		},
		typescript = {
			{
				formatCommand = "bunx prettier --parser typescript",
				formatStdin = true,
			},
		},
		svelte = {
			{
				formatCommand = "bunx prettier --parser svelte",
				formatStdin = true,
			},
		},
		css = {
			{
				formatCommand = "bunx prettier --parser css",
				formatStdin = true,
			},
		},
		scss = {
			{
				formatCommand = "bunx prettier --parser scss",
				formatStdin = true,
			},
		},
	},
}

settings.lintDebounce = 1000

require("lspconfig").efm.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = settings,
	filetypes = {
		"python",
		"lua",
		"vue",
		"cs",
		"sql",
		"json",
		"html",
		"css",
		"scss",
		"javascript",
		"typescript",
		"svelte",
	},
	init_options = { documentFormatting = true, diagnostics = true },
	root_dir = function(fname)
		return not bufdir:find(work_keyword) and util.root_pattern("node_modules")(fname)
			or not bufdir:find(work_keyword) and util.root_pattern(".git")(fname)
			or vim.fn.getcwd()
	end,
})

require("lsp_signature").setup()
