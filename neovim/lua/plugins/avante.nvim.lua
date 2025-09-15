return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = true,
	version = false, -- set this if you want to always pull the latest change
	opts = {
		-- add any opts here
	},
	config = function()
		require("avante").setup({
			provider = "copilot",
			auto_suggestions_provider = "copilot",
		})
	end,
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make BUILD_FROM_SOURCE=true",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
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
						avante = false,
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
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
			event = "VeryLazy",
		},
	},
}
