return require("packer").startup(function(use)
	-- packer
	use("wbthomason/packer.nvim")

	-- vim plugins
	use("terryma/vim-multiple-cursors")
	use("sheerun/vim-polyglot")
	use("unblevable/quick-scope")
	use("tpope/vim-fugitive")
	use("joshdick/onedark.vim")
	use("tpope/vim-surround")
	use("luochen1990/rainbow")
	use({ "ms-jpq/chadtree", branch = "chad", run = "python3 -m chadtree deps" })

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
	use("nvim-telescope/telescope.nvim")
	use("numToStr/Comment.nvim")
	use("lewis6991/gitsigns.nvim")
	use("folke/trouble.nvim")
	use("feline-nvim/feline.nvim")
	use("lukas-reineke/indent-blankline.nvim")
end)
