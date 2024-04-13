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
	{
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({
				enabled = true,
				write_all_buffers = true,
				condition = function(buf)
					local fn = vim.fn
					local utils = require("auto-save.utils.data")
					if
						fn.getbufvar(buf, "&modifiable") == 1
						and utils.not_in(fn.getbufvar(buf, "&filetype"), { "octo" })
					then
						return true -- met condition(s), can save
					end
					return false -- can't save
				end,
			})
		end,
	},
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
	{
		"pwntester/octo.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("octo").setup({
				suppress_missing_scope = {
					projects_v2 = true,
				},
				always_select_remote_on_create = true,
				default_remote = { "origin" },
				mappings_disable_default = true,
				mappings = {
					issue = {
						-- close_issue = { lhs = "<space>ic", desc = "close issue" },
						-- reopen_issue = { lhs = "<space>io", desc = "reopen issue" },
						-- list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
						-- reload = { lhs = "<C-r>", desc = "reload issue" },
						-- open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
						-- copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
						-- add_assignee = { lhs = "<space>aa", desc = "add assignee" },
						-- remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
						-- create_label = { lhs = "<space>lc", desc = "create label" },
						-- add_label = { lhs = "<space>la", desc = "add label" },
						-- remove_label = { lhs = "<space>ld", desc = "remove label" },
						-- goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
						-- add_comment = { lhs = "<space>ca", desc = "add comment" },
						-- delete_comment = { lhs = "<space>cd", desc = "delete comment" },
						-- next_comment = { lhs = "]c", desc = "go to next comment" },
						-- prev_comment = { lhs = "[c", desc = "go to previous comment" },
						-- react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
						-- react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
						-- react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
						-- react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
						-- react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
						-- react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
						-- react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
						-- react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
					},
					pull_request = {
						-- checkout_pr = { lhs = "<space>po", desc = "checkout PR" },
						-- merge_pr = { lhs = "<space>pm", desc = "merge commit PR" },
						-- squash_and_merge_pr = { lhs = "<space>psm", desc = "squash and merge PR" },
						-- rebase_and_merge_pr = { lhs = "<space>prm", desc = "rebase and merge PR" },
						-- list_commits = { lhs = "<space>pc", desc = "list PR commits" },
						-- list_changed_files = { lhs = "<space>pf", desc = "list PR changed files" },
						-- show_pr_diff = { lhs = "<space>pd", desc = "show PR diff" },
						-- add_reviewer = { lhs = "<space>va", desc = "add reviewer" },
						-- remove_reviewer = { lhs = "<space>vd", desc = "remove reviewer request" },
						-- close_issue = { lhs = "<space>ic", desc = "close PR" },
						-- reopen_issue = { lhs = "<space>io", desc = "reopen PR" },
						-- list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
						reload = { lhs = "<C-r>", desc = "reload PR" },
						open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
						copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
						-- goto_file = { lhs = "gf", desc = "go to file" },
						-- add_assignee = { lhs = "<space>aa", desc = "add assignee" },
						-- remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
						-- create_label = { lhs = "<space>lc", desc = "create label" },
						-- add_label = { lhs = "<space>la", desc = "add label" },
						-- remove_label = { lhs = "<space>ld", desc = "remove label" },
						-- goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
						-- add_comment = { lhs = "<space>ca", desc = "add comment" },
						delete_comment = { lhs = "<space>cd", desc = "delete comment" },
						next_comment = { lhs = "]c", desc = "go to next comment" },
						prev_comment = { lhs = "[c", desc = "go to previous comment" },
						-- react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
						-- react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
						-- react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
						-- react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
						-- react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
						-- react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
						-- react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
						-- react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
						-- review_start = { lhs = "<space>vs", desc = "start a review for the current PR" },
						-- review_resume = { lhs = "<space>vr", desc = "resume a pending review for the current PR" },
					},
					review_thread = {
						-- goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
						-- add_comment = { lhs = "<space>ca", desc = "add comment" },
						-- add_suggestion = { lhs = "<space>sa", desc = "add suggestion" },
						-- delete_comment = { lhs = "<space>cd", desc = "delete comment" },
						next_comment = { lhs = "]c", desc = "go to next comment" },
						prev_comment = { lhs = "[c", desc = "go to previous comment" },
						select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
						select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
						select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
						select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
						-- close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
						-- react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
						-- react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
						-- react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
						-- react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
						-- react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
						-- react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
						-- react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
						-- react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
					},
					submit_win = {
						approve_review = { lhs = "<C-a>", desc = "approve review" },
						comment_review = { lhs = "<C-m>", desc = "comment review" },
						request_changes = { lhs = "<C-r>", desc = "request changes review" },
						close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
					},
					review_diff = {
						-- submit_review = { lhs = "<leader>vs", desc = "submit review" },
						-- discard_review = { lhs = "<leader>vd", desc = "discard review" },
						-- add_review_comment = { lhs = "<space>ca", desc = "add a new review comment" },
						-- add_review_suggestion = { lhs = "<space>sa", desc = "add a new review suggestion" },
						-- focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
						-- toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
						next_thread = { lhs = "]t", desc = "move to next thread" },
						prev_thread = { lhs = "[t", desc = "move to previous thread" },
						select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
						select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
						select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
						select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
						-- close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
						-- toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
						goto_file = { lhs = "gf", desc = "go to file" },
					},
					file_panel = {
						-- submit_review = { lhs = "<leader>vs", desc = "submit review" },
						-- discard_review = { lhs = "<leader>vd", desc = "discard review" },
						next_entry = { lhs = "j", desc = "move to next changed file" },
						prev_entry = { lhs = "k", desc = "move to previous changed file" },
						-- select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
						refresh_files = { lhs = "R", desc = "refresh changed files panel" },
						-- focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
						-- toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
						select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
						select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
						select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
						select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
						close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
						-- toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
					},
				},
			})
		end,
	},
}

require("lazy").setup(plugins, {
	install = {
		missing = true,
		colorscheme = { "gruvbox-material" },
	},
})
