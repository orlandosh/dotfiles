return require("packer").startup(function(use)
	-- TODO: properly sort plugins and deps

	-- packer
	use("wbthomason/packer.nvim")

	-- themes
	-- use("ellisonleao/gruvbox.nvim")
	use("sainnhe/gruvbox-material")
	-- use("joshdick/onedark.vim")

	-- vim plugins
	use("terryma/vim-multiple-cursors")
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

	-- nvim-only plugins
	-- TODO: add plugin to index TODOs
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
	use("folke/trouble.nvim")
	use("feline-nvim/feline.nvim")
	use({
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use("lukas-reineke/indent-blankline.nvim")
	use("norcalli/nvim-colorizer.lua")
	use("stevearc/dressing.nvim")
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

	use("f-person/git-blame.nvim")

	-- neotree
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = require("plugins.neotree"),
	})

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
						open = "<M-a>",
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
				},
				copilot_node_command = "node", -- Node.js version must be > 16.x
				server_opts_overrides = {},
			})
		end,
	})
end)
