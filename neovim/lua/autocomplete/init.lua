-- TODO: move this entire module out of here
local opts = { noremap = true, silent = true }
require("keymaps").cmp_keymaps(opts)
local on_attach = require("autocomplete.on_attach")(opts)
local utils = require("utils")
local util = require("lspconfig/util")

require("autocomplete.cmp")

local bufdir = utils.get_dir()
local work_keyword = require("utils").WORK_KEYWORD

local lspconfig = require("lspconfig")
local installed_servers = require("mason-lspconfig").get_installed_servers()
if utils.file_exists("/usr/bin/clangd") then
	table.insert(installed_servers, "clangd")
end

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
})

for _, server in pairs(installed_servers) do
	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
	local lsp_opts = { on_attach = on_attach, capabilities = capabilities }

	if server == "basedpyright" then
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
		local settings_json = require("utils").get_json(bufdir .. "rust_analyzer_neovim.json")

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

	if server == "ts_ls" then
		-- lsp_opts.settings = {
		-- 	typescript = {
		-- 		inlayHints = {
		-- 			includeInlayParameterNameHints = "all",
		-- 			includeInlayParameterNameHintsWhenArgumentMatchesName = false,
		-- 			includeInlayFunctionParameterTypeHints = true,
		-- 			includeInlayVariableTypeHints = true,
		-- 			includeInlayVariableTypeHintsWhenTypeMatchesName = false,
		-- 			includeInlayPropertyDeclarationTypeHints = true,
		-- 			includeInlayFunctionLikeReturnTypeHints = true,
		-- 			includeInlayEnumMemberValueHints = true,
		-- 		},
		-- 	},
		-- 	javascript = {
		-- 		inlayHints = {
		-- 			includeInlayParameterNameHints = "all",
		-- 			includeInlayParameterNameHintsWhenArgumentMatchesName = false,
		-- 			includeInlayFunctionParameterTypeHints = true,
		-- 			includeInlayVariableTypeHints = true,
		-- 			includeInlayVariableTypeHintsWhenTypeMatchesName = false,
		-- 			includeInlayPropertyDeclarationTypeHints = true,
		-- 			includeInlayFunctionLikeReturnTypeHints = true,
		-- 			includeInlayEnumMemberValueHints = true,
		-- 		},
		-- 	},
		-- }
		--
		lsp_opts.root_dir =
			lspconfig.util.root_pattern("nx.json", ".git", "workspace.json", "package.json", "tsconfig.base.json")
	end

	if server == "lua_ls" then
		lsp_opts.on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			on_attach(client, bufnr)
		end
	end

	if server == "efm" then
		local python_formatter = "black --quiet - | isort --stdout --profile black - | black --quiet -"
		if string.find(bufdir, work_keyword) then
			python_formatter = "darker --stdout ${INPUT}"
		end

		local settings = {
			lintDebounce = 1000,
			languages = {
				python = {
					{
						formatCommand = python_formatter,
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
						formatCommand = "prettier --parser vue --tab-width 2",
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
						formatCommand = "prettier --parser json --tab-width 2",
						formatStdin = true,
					},
				},
				html = {
					{
						formatCommand = "prettier --parser html --tab-width 2",
						formatStdin = true,
					},
				},
				javascript = {
					{
						formatCommand = "prettier --parser babel --tab-width 2",
						formatStdin = true,
					},
				},
				typescript = {
					{
						formatCommand = "biome format - --stdin-file-path=${INPUT}",
						formatStdin = true,
					},
				},
				typescriptreact = {
					{
						formatCommand = "biome format - --stdin-file-path=${INPUT}",
						formatStdin = true,
					},
				},
				svelte = {
					{
						formatCommand = "prettier --parser svelte --tab-width 2",
						formatStdin = true,
					},
				},
				css = {
					{
						formatCommand = "prettier --parser css --tab-width 2",
						formatStdin = true,
					},
				},
				scss = {
					{
						formatCommand = "prettier --parser scss --tab-width 2",
						formatStdin = true,
					},
				},
                yaml = {
                    {
                        formatCommand = "prettier --parser yaml --tab-width 2",
                        formatStdin = true,
                    }
                }
			},
		}

		settings.lintDebounce = 1000

		lspconfig[server].setup({
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
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"svelte",
				"c",
				"cpp",
                "yaml",
			},
			init_options = { documentFormatting = true, diagnostics = true },
			root_dir = function(fname)
				return not bufdir:find(work_keyword) and util.root_pattern("node_modules")(fname)
					or not bufdir:find(work_keyword) and util.root_pattern(".git")(fname)
					or vim.fn.getcwd()
			end,
		})
	end

	if server ~= "efm" then
		lspconfig[server].setup(lsp_opts)
	end
end
