local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- TODO: properly sort plugins and deps
	-- TODO: add sidebar-nvim
	-- TODO: setup debuggers

	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme gruvbox-material]])
		end,
	},

	-- vim plugins
	"mg979/vim-visual-multi",
	"sheerun/vim-polyglot",
	"unblevable/quick-scope",
	"tpope/vim-fugitive",

	-- TODO: reorganize
	-- nvim lsp, autocomplete, lint & snip related
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/vim-vsnip",
	"mfussenegger/nvim-lint",
	"ray-x/lsp_signature.nvim",
	"folke/lsp-colors.nvim",
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup()
		end,
	},
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	{
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			require("lsp-inlayhints").setup()
		end,
	},

	{
		"kosayoda/nvim-lightbulb",
		config = function()
			require("nvim-lightbulb").setup({
				autocmd = { enabled = true },
			})
		end,
	},
	-- add lspkind
	"onsails/lspkind-nvim",

	-- nvim-only plugins
	"Pocco81/auto-save.nvim",
	"nvim-lua/plenary.nvim",
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	"lewis6991/gitsigns.nvim",
	"feline-nvim/feline.nvim",
	{
		"romgrk/barbar.nvim",
	},
	"lukas-reineke/indent-blankline.nvim",
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				css = { css = true },
			})
		end,
	},
	"stevearc/dressing.nvim",
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	},

	{
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
				filetype_overrides = {
					python = {
						providers = {
							"lsp",
							"regex",
						},
					},
				},
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
	},
	-- use({
	-- 	"goolord/alpha-nvim",
	-- 	config = function()
	-- 		require("alpha").setup(require("alpha.themes.dashboard").config)
	-- 	end,
	-- })
	"Shatur/neovim-session-manager",
	"kdheepak/lazygit.nvim",
	-- use("mfussenegger/nvim-dap")
	-- use("rcarriga/nvim-dap-ui")
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup()
		end,
	},

	{
		"nvim-pack/nvim-spectre",
		config = function()
			require("spectre").setup()
		end,
	},
	"f-person/git-blame.nvim",

	-- neotree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = require("plugins.neotree"),
	},
	"nvim-tree/nvim-web-devicons",

	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"hkupty/iron.nvim",

	-- autotag
	"windwp/nvim-ts-autotag",

	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({
				highlight = {
					before = "",
					keyword = "bg",
					after = "",
				},
			})
		end,
	},

	-- copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "VeryLazy",
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
	},

	{
		"SmiteshP/nvim-navbuddy",
		dependencies = {
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
	},

	{
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
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup()
		end,
	},
	"tpope/vim-dadbod",
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
			ft = { "sql", "plsql", "clickhouse" },
		},
		config = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"backdround/improved-search.nvim",
		config = function()
			local search = require("improved-search")
			-- Search next / previous.
			vim.keymap.set({ "n", "x", "o" }, "n", search.stable_next)
			vim.keymap.set({ "n", "x", "o" }, "N", search.stable_previous)

			-- Search current word without moving.
			vim.keymap.set("n", "!", search.current_word)

			-- Search selected text in visual mode
			vim.keymap.set("x", "!", search.in_place) -- search selection without moving
			vim.keymap.set("x", "*", search.forward) -- search selection forward
			vim.keymap.set("x", "#", search.backward) -- search selection backward

			-- Search by motion in place
			vim.keymap.set("n", "|", search.in_place)
			-- You can also use search.forward / search.backward for motion selection.
		end,
	},

	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	branch = "canary",
	-- 	dependencies = {
	-- 		"zbirenbaum/copilot.lua", -- or github/copilot.vim
	-- 		{ "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
	-- 		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
	-- 	},
	-- 	opts = {
	-- 		debug = true, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
	-- 	},
	-- 	config = function(_, opts)
	-- 		local chat = require("CopilotChat")
	-- 		local select = require("CopilotChat.select")
	--
	-- 		chat.setup(opts)
	--
	-- 		-- Restore CopilotChatVisual
	-- 		vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
	-- 			chat.ask(args.args, { selection = select.visual })
	-- 		end, { nargs = "*", range = true })
	--
	-- 		-- Restore CopilotChatInPlace (sort of)
	-- 		vim.api.nvim_create_user_command("CopilotChatInPlace", function(args)
	-- 			chat.ask(args.args, { selection = select.visual, window = { layout = "float" } })
	-- 		end, { nargs = "*", range = true })
	--
	-- 		-- Restore CopilotChatBuffer
	-- 		vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
	-- 			chat.ask(args.args, { selection = select.buffer })
	-- 		end, { nargs = "*", range = true })
	-- 	end,
	-- 	event = "VeryLazy",
	-- 	keys = {
	-- 		{ "<leader>ccb", "<cmd>CopilotChatBuffer ", desc = "CopilotChat - Chat with current buffer" },
	-- 		{ "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
	-- 		{ "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
	-- 		{
	-- 			"<leader>ccv",
	-- 			":CopilotChatVisual ",
	-- 			mode = "x",
	-- 			desc = "CopilotChat - Open in vertical split",
	-- 		},
	-- 		{
	-- 			"<leader>ccx",
	-- 			":CopilotChatInPlace<cr>",
	-- 			mode = "x",
	-- 			desc = "CopilotChat - Run in-place code",
	-- 		},
	-- 		{
	-- 			"<leader>ccf",
	-- 			"<cmd>CopilotChatFixDiagnostic<cr>", -- Get a fix for the diagnostic message under the cursor.
	-- 			desc = "CopilotChat - Fix diagnostic",
	-- 		},
	-- 	},
	-- },


	"smithbm2316/centerpad.nvim",
}

require("lazy").setup(plugins, {
	install = {
		missing = true,
		colorscheme = { "gruvbox-material" },
	},
})
