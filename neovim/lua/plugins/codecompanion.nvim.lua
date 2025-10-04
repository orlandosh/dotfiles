return {
	"olimorris/codecompanion.nvim",
	main = "codecompanion",
	event = "VeryLazy",
	lazy = true,
	version = false,
	opts = {
		strategies = {
			-- Use GitHub Copilot as the adapter for both chat and inline
			chat = { adapter = { name = "copilot", model = "gpt-5-mini" } },
			inline = { adapter = { name = "copilot", model = "gpt-5-mini" } },
		},
	},
	config = function(_, opts)
		-- Help the Copilot adapter find the token files
		vim.env.CODECOMPANION_TOKEN_PATH = vim.env.CODECOMPANION_TOKEN_PATH or vim.fn.expand("~/.config")
		require("codecompanion").setup(opts)
	end,
	dependencies = {
		-- Core deps
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",

		-- Copilot for inline suggestions (separate from CodeCompanion adapter)
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
						layout = { position = "bottom", ratio = 0.4 },
					},
					suggestion = {
						enabled = true,
						auto_trigger = true,
						debounce = 75,
						keymap = {
							accept = "<M-CR>",
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
						codecompanion = false,
						sh = function()
							if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
								return false
							end
							if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.zsh_history.*") then
								return false
							end
							return true
						end,
					},
					copilot_node_command = "node",
					server_opts_overrides = {
						trace = "verbose",
						advanced = { listCount = 10, inlineSuggestionCount = 10 },
					},
				})
			end,
		},

		-- Image paste support (pastes files and inserts Markdown links)
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				filetypes = {
					codecompanion = {
						prompt_for_file_name = false,
						template = "[Image]($FILE_PATH)",
						use_absolute_path = true,
					},
				},
			},
		},

		-- Render Markdown in chat buffers
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "codecompanion" },
			},
			ft = { "markdown", "codecompanion" },
			event = "VeryLazy",
		},
	},
}
