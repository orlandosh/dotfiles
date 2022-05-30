return require("packer").startup(function(use)
	-- TODO: properly sort plugins and deps

	-- packer
	use("wbthomason/packer.nvim")

	-- themes
	use("ellisonleao/gruvbox.nvim")
	use("sainnhe/gruvbox-material")
	-- use("joshdick/onedark.vim")

	-- vim plugins
	use("terryma/vim-multiple-cursors")
	use("sheerun/vim-polyglot")
	use("unblevable/quick-scope")
	use("tpope/vim-fugitive")
	use("tpope/vim-surround")
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
	use("williamboman/nvim-lsp-installer")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- nvim-only plugins
	-- TODO: add plugin to index TODOs
	use("Pocco81/AutoSave.nvim")
	use("nvim-lua/plenary.nvim")
	use({ "nvim-telescope/telescope.nvim", requires = { { "nvim-lua/plenary.nvim" } } })
	use("numToStr/Comment.nvim")
	use("lewis6991/gitsigns.nvim")
	use("folke/trouble.nvim")
	use("feline-nvim/feline.nvim")
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
	use("mfussenegger/nvim-dap")

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
end)
