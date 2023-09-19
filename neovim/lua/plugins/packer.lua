return require("packer").startup(function(use)
	-- TODO: properly sort plugins and deps
	-- TODO: add sidebar-nvim
	-- TODO: setup debuggers

	-- packer
	use("wbthomason/packer.nvim")

	-- themes
	-- use("ellisonleao/gruvbox.nvim")
	use("sainnhe/gruvbox-material")
	-- use("joshdick/onedark.vim")

	-- vim plugins
	-- -- use("terryma/vim-multiple-cursors")
	use("mg979/vim-visual-multi")
	use("sheerun/vim-polyglot")
	use("unblevable/quick-scope")
	use("tpope/vim-fugitive")
	-- use("luochen1990/rainbow")
	-- replaced by neotree use({ "ms-jpq/chadtree", branch = "chad", run = "python3 -m chadtree deps" })

	-- TODO: reorganize
	-- nvim lsp, autocomplete, lint & snip related
	use("neovim/nvim-lspconfig")
	use("windwp/nvim-autopairs")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")
	use("mfussenegger/nvim-lint")
	use("ray-x/lsp_signature.nvim")
	use("folke/lsp-colors.nvim")
	use({
		"williamboman/mason.nvim",
		run = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			require("mason").setup()
		end,
	})
	use({
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup()
		end,
	})
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	use({
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			require("lsp-inlayhints").setup()
		end,
	})

	use({
		"kosayoda/nvim-lightbulb",
		config = function()
			require("nvim-lightbulb").setup({
				autocmd = { enabled = true },
			})
		end,
	})
	-- add lspkind
	use({
		"onsails/lspkind-nvim",
	})

	-- nvim-only plugins
	use("Pocco81/auto-save.nvim")
	use("nvim-lua/plenary.nvim")
	use({ "nvim-telescope/telescope.nvim", requires = { { "nvim-lua/plenary.nvim" } } })
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use("lewis6991/gitsigns.nvim")
	use("feline-nvim/feline.nvim")
	use({
		"romgrk/barbar.nvim",
	})
	use("lukas-reineke/indent-blankline.nvim")
	use("norcalli/nvim-colorizer.lua")
	use("stevearc/dressing.nvim")
	use({
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	})
	use({
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				-- providers: provider used to get references in the buffer, ordered by priority
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				-- delay: delay in milliseconds
				delay = 100,
				-- filetype_overrides: filetype specific overrides.
				-- The keys are strings to represent the filetype while the values are tables that
				-- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
				filetype_overrides = {},
				-- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
				filetypes_denylist = {
					"dirvish",
					"fugitive",
				},
				-- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
				filetypes_allowlist = {},
				-- modes_denylist: modes to not illuminate, this overrides modes_allowlist
				-- See `:help mode()` for possible values
				modes_denylist = {},
				-- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
				-- See `:help mode()` for possible values
				modes_allowlist = {},
				-- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
				-- Only applies to the 'regex' provider
				-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
				providers_regex_syntax_denylist = {},
				-- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
				-- Only applies to the 'regex' provider
				-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
				providers_regex_syntax_allowlist = {},
				-- under_cursor: whether or not to illuminate under the cursor
				under_cursor = true,
				-- large_file_cutoff: number of lines at which to use large_file_config
				-- The `under_cursor` option is disabled when this cutoff is hit
				large_file_cutoff = nil,
				-- large_file_config: config to use for large files (based on large_file_cutoff).
				-- Supports the same keys passed to .configure
				-- If nil, vim-illuminate will be disabled for large files.
				large_file_overrides = nil,
				-- min_count_to_highlight: minimum number of matches required to perform highlighting
				min_count_to_highlight = 1,
			})
		end,
	})
	-- use({
	-- 	"goolord/alpha-nvim",
	-- 	config = function()
	-- 		require("alpha").setup(require("alpha.themes.dashboard").config)
	-- 	end,
	-- })
	use("Shatur/neovim-session-manager")
	use("kdheepak/lazygit.nvim")
	-- use("mfussenegger/nvim-dap")
	-- use("rcarriga/nvim-dap-ui")
	use({
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup()
		end,
	})

	use({
		"nvim-pack/nvim-spectre",
		config = function()
			require("spectre").setup()
		end,
	})
	use("f-person/git-blame.nvim")

	-- neotree
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = require("plugins.neotree"),
	})
	use({ "nvim-tree/nvim-web-devicons" })

	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("karb94/neoscroll.nvim")
	use("hkupty/iron.nvim")

	-- autotag
	use("windwp/nvim-ts-autotag")

	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})

	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				highlight = {
					before = "",
					keyword = "bg",
					after = "",
				},
			})
		end,
	})

	-- copilot
	use({
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = true,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-m>",
					},
					layout = {
						position = "bottom", -- | top | left | right
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<M-CR>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
					zsh = false,
					sh = function()
						if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
							-- disable for .env files
							return false
						end
						if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.zsh_history.*") then
							-- disable for .zsh_history
							return false
						end
						return true
					end,
				},
				copilot_node_command = "node", -- Node.js version must be > 16.x
				server_opts_overrides = {
					trace = "verbose",
					advanced = {
						listCount = 10,
						inlineSuggestionCount = 10,
					},
				},
			})
		end,
	})

	use({
		"SmiteshP/nvim-navbuddy",
		requires = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
			"numToStr/Comment.nvim", -- Optional
			"nvim-telescope/telescope.nvim", -- Optional
		},
		config = function()
			require("nvim-navic").setup({
				icons = {
					File = " ",
					Module = " ",
					Namespace = " ",
					Package = " ",
					Class = " ",
					Method = " ",
					Property = " ",
					Field = " ",
					Constructor = " ",
					Enum = " ",
					Interface = " ",
					Function = " ",
					Variable = " ",
					Constant = " ",
					String = " ",
					Number = " ",
					Boolean = " ",
					Array = " ",
					Object = " ",
					Key = " ",
					Null = " ",
					EnumMember = " ",
					Struct = " ",
					Event = " ",
					Operator = " ",
					TypeParameter = " ",
				},
				highlight = true,
			})

			require("nvim-navbuddy").setup({
				icons = {
					File = " ",
					Module = " ",
					Namespace = " ",
					Package = " ",
					Class = " ",
					Method = " ",
					Property = " ",
					Field = " ",
					Constructor = " ",
					Enum = " ",
					Interface = " ",
					Function = " ",
					Variable = " ",
					Constant = " ",
					String = " ",
					Number = " ",
					Boolean = " ",
					Array = " ",
					Object = " ",
					Key = " ",
					Null = " ",
					EnumMember = " ",
					Struct = " ",
					Event = " ",
					Operator = " ",
					TypeParameter = " ",
				},
			})
		end,
	})

	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup({
				-- use vscode icons
				symbols = {
					File = { icon = " ", hl = "@text.uri" },
					Module = { icon = " ", hl = "@namespace" },
					Namespace = { icon = " ", hl = "@namespace" },
					Package = { icon = " ", hl = "@namespace" },
					Class = { icon = " ", hl = "@type" },
					Method = { icon = " ", hl = "@method" },
					Property = { icon = " ", hl = "@method" },
					Field = { icon = " ", hl = "@field" },
					Constructor = { icon = " ", hl = "@constructor" },
					Enum = { icon = " ", hl = "@type" },
					Interface = { icon = " ", hl = "@type" },
					Function = { icon = " ", hl = "@function" },
					Variable = { icon = " ", hl = "@constant" },
					Constant = { icon = " ", hl = "@constant" },
					String = { icon = " ", hl = "@string" },
					Number = { icon = " ", hl = "@number" },
					Boolean = { icon = " ", hl = "@boolean" },
					Array = { icon = " ", hl = "@constant" },
					Object = { icon = " ", hl = "@type" },
					Key = { icon = " ", hl = "@type" },
					Null = { icon = " ", hl = "@type" },
					EnumMember = { icon = " ", hl = "@field" },
					Struct = { icon = " ", hl = "@type" },
					Event = { icon = " ", hl = "@type" },
					Operator = { icon = " ", hl = "@operator" },
					TypeParameter = { icon = " ", hl = "@parameter" },
					Component = { icon = " ", hl = "@function" },
					Fragment = { icon = " ", hl = "@constant" },
				},
			})
		end,
	})
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})
	use({ "tpope/vim-dadbod" })
	use({
		"kristijanhusak/vim-dadbod-ui",
		requires = { "tpope/vim-dadbod", "kristijanhusak/vim-dadbod-completion", ft = { "sql", "plsql", "clickhouse" } },
		config = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	})
end)
