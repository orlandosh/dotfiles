require("nvim-treesitter.configs").setup({
	ensure_installed = { "python", "vue", "javascript", "rust", "lua", "sql", "html" },
	sync_install = false,
	indent = { enable = true },
	autopairs = { enable = true },
	auto_install = true,

	highlight = {
		enable = true,
		disable = function(lang, _)
			-- disable if lang not in {"json", "sql"}
			return not ({ json = true, sql = true })[lang]
		end,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = true,
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn", -- set to `false` to disable one of the mappings
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
})
