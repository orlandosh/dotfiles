return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		"tpope/vim-dadbod",
		"kristijanhusak/vim-dadbod-completion",
	},
	ft = { "sql", "plsql", "clickhouse" },
	config = function()
		vim.g.db_ui_use_nerd_fonts = 1
	end,
}
