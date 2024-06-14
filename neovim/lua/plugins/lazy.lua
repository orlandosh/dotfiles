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
	-- TODO: setup debuggers
	-- NOTE: this is currently chaos. i will reorganize this later

	-- themes
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme gruvbox-material]])
		end,
	},

	{ "sainnhe/everforest", event = "VeryLazy" },

	{
		"catppuccin/nvim",
		event = "VeryLazy",
		config = function()
			require("catppuccin").setup({
				background = {
					light = "latte",
					dark = "frappe",
				},

				term_colors = true,
				default_integrations = true,
				integrations = {
					notify = true,
					noice = true,
					barbar = true,
					navic = { enabled = true },
					neotest = true,
					neotree = true,
					neogit = true,
					telescope = true,
					cmp = true,
					octo = true,
					indent_blankline = { enabled = true },
					illuminate = { enabled = true, lsp = false },
					native_lsp = {
						enabled = true,

						inlay_hints = {
							background = false,
						},
					},
				},
			})
		end,
	},
	{ "rebelot/kanagawa.nvim", event = "VeryLazy" },

	-- vim plugins
	{ "mg979/vim-visual-multi", event = "VeryLazy" },

	{ "unblevable/quick-scope", event = "VeryLazy" },

	-- TODO: reorganize
	-- nvim lsp, autocomplete, lint & snip related
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {

			"onsails/lspkind-nvim",
			{
				"kosayoda/nvim-lightbulb",
				config = function()
					require("nvim-lightbulb").setup({
						autocmd = { enabled = true },
					})
				end,
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			{
				"hrsh7th/cmp-vsnip",
				dependencies = {
					"hrsh7th/vim-vsnip",
				},
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		ft = { "python" },
		config = function()
			local lint = { lint = require("lint") }

			local pylint = require("lint.linters.pylint")

			local bufdir = require("utils").get_dir()
			local work_keyword = require("utils").WORK_KEYWORD

			if bufdir:find(work_keyword) or bufdir:find("dango") then
				pylint.cmd = "poetry"
				pylint.args = {
					"run",
					"pylint",
					unpack(pylint.args),
				}
			end

			local python_linters = { "pylint" }
			if string.find(bufdir, work_keyword) then
				table.insert(python_linters, "flake8")
			end

			return lint
		end,
	},

	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			require("mason").setup()
		end,
		event = "VeryLazy",
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				config = function()
					require("mason-lspconfig").setup()
				end,
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "python", "vue", "javascript", "rust", "lua", "sql", "html", "regex", "bash" },
				sync_install = false,
				indent = { enable = true },
				auto_install = true,

				highlight = {
					enable = true,
					disable = function(lang, _)
						-- disable if lang not in {"json", "sql"}
						return not ({ json = true, sql = true, svelte = true })[lang]
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
		end,
	},

	-- add lspkind

	-- nvim-only plugins
	{
		"Pocco81/auto-save.nvim",
		event = "VeryLazy",
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
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		event = "VeryLazy",
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "%.po", "assets" },
					mappings = {
						n = { ["dd"] = actions.delete_buffer },
					},
					cache_picker = {
						num_pickers = 100,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("live_grep_args")
		end,
	},

	-- TODO: customize appearance
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
		event = "VeryLazy",
	},
	{
		"feline-nvim/feline.nvim",
		event = "VeryLazy",
		config = function()
			local function ensure_hexadecimal(input)
				local function to_hexadecimal_num(num)
					return "#" .. string.format("%X", num)
				end

				if type(input) == "number" then
					return to_hexadecimal_num(input)
				elseif input == nil then
					return nil
				else
					error("Unsupported input type. Must be a number. Got: " .. type(input))
				end
			end

			local function setup_theme()
				local black = ensure_hexadecimal(vim.api.nvim_get_hl(0, { name = "BufferTabpageFill" }).bg)
				if black == nil then
					black = ensure_hexadecimal(vim.api.nvim_get_hl(0, { name = "BufferDefaultTabpageFill" }).bg)
				end
				MyTheme = {
					bg = ensure_hexadecimal(vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg),
					fg = ensure_hexadecimal(vim.api.nvim_get_hl(0, { name = "StatusLine" }).fg),
					black = black,
					blue = G.terminal_color_4,
					cyan = G.terminal_color_6,
					darkblue = G.terminal_color_4,
					green = G.terminal_color_2,
					oceanblue = G.terminal_color_4,
					orange = G.terminal_color_3,
					magenta = G.terminal_color_5,
					red = G.terminal_color_1,
					skyblue = G.terminal_color_4,
					white = G.terminal_color_7,
					yellow = G.terminal_color_3,
				}
			end

			setup_theme()

			local fe_vi_mode = require("feline.providers.vi_mode")
			local fe_file = require("feline.providers.file")
			local fe_git = require("feline.providers.git")
			local fe_cursor = require("feline.providers.cursor")

			local git_blame_pl = require("gitblame")

			local file_name = {
				provider = function(component)
					local file_name, _ = fe_file.file_info(component, { type = "unique" })
					local pos = fe_cursor.position(component, {}):gsub("%s+", "")
					local percent = fe_cursor.line_percentage():lower():gsub("%s+", "")

					if percent:find("bot") then
						percent = "100%%"
					elseif percent:find("top") then
						percent = "0%%"
					end

					percent = percent:format("%-4s", percent) .. "%"
					local pos_percent = string.format("%-16s", pos .. ":" .. percent)

					local icon_str, icon_color =
						require("nvim-web-devicons").get_icon_colors_by_filetype(vim.bo.filetype, { default = true })

					local icon = { str = icon_str }
					icon.hl = { fg = icon_color }

					return file_name .. ":" .. pos_percent, icon
				end,
				left_sep = " ",
			}

			local vi_mode = {
				provider = function()
					return fe_vi_mode.get_vim_mode():lower()
				end,

				hl = function()
					return { name = fe_vi_mode.get_mode_highlight_name():lower(), fg = fe_vi_mode.get_mode_color() }
				end,

				left_sep = " ",
			}

			local file_line_str = fe_file.file_format():lower()

			local file_line = {
				provider = function()
					return file_line_str
				end,

				enabled = function()
					return file_line_str ~= "unix" -- it's only important to know when it's not unix anyway lol
				end,

				left_sep = " ",
			}

			local git_branch = {
				provider = { name = "git_branch" },
				right_sep = " ",
				left_sep = "  ",
				hl = function()
					-- if branch contains feature, highlight green
					-- if branch contains hotfix, highlight red
					-- if branch contains bugfix, highlight yellow

					if fe_git.git_branch():find("feature") then
						return { fg = "green" }
					elseif fe_git.git_branch():find("hotfix") then
						return { fg = "red" }
					elseif fe_git.git_branch():find("bugfix") then
						return { fg = "yellow" }
					end
				end,
			}
			local git_diff = {}

			git_diff.add = {
				provider = function()
					return " " .. fe_git.git_diff_added()
				end,

				hl = function()
					return { fg = "blue" }
				end,

				enabled = function()
					return fe_git.git_diff_added() ~= ""
				end,

				right_sep = " ",
			}

			git_diff.modify = {
				provider = function()
					return " " .. fe_git.git_diff_changed()
				end,

				hl = function()
					return { fg = "orange" }
				end,

				enabled = function()
					return fe_git.git_diff_changed() ~= ""
				end,

				right_sep = " ",
			}

			git_diff.del = {
				provider = function()
					return " " .. fe_git.git_diff_removed()
				end,

				hl = function()
					return { fg = "red" }
				end,

				enabled = function()
					return fe_git.git_diff_removed() ~= ""
				end,

				right_sep = " ",
			}

			local diagnostic_errors = { provider = "diagnostic_errors", hl = { fg = "magenta" }, right_sep = "" }
			local diagnostic_warnings = { provider = "diagnostic_warnings", hl = { fg = "yellow" }, right_sep = "" }
			local diagnostic_hints = { provider = "diagnostic_hints", hl = { fg = "cyan" }, right_sep = "" }
			local diagnostic_info = { provider = "diagnostic_info", hl = { fg = "white" }, right_sep = "" }
			local search_count = { provider = "search_count", right_sep = " " }

			local function abbreviate_name(blame_text)
				if blame_text == nil then
					return ""
				end

				local name = blame_text:match("(.*) •")
				local date = blame_text:match("• (.*) #")
				local sha = blame_text:match("#(.*)")

				if name == nil or date == nil or sha == nil then
					return blame_text
				end

				local name_short = ""
				local name_words = vim.split(name, " ")
				local name_words_count = #name_words

				if name_words_count == 1 then
					name_short = name_words[1]:lower()
				else
					name_short = name_words[1]:lower() .. " " .. name_words[2]:sub(1, 1):lower()
				end

				return name_short .. " • " .. date .. " #" .. sha
			end

			local git_blame = {
				provider = function()
					if
						(G.gitblame_enabled ~= nil and not G.gitblame_enabled)
						or not git_blame_pl.is_blame_text_available()
					then
						return ""
					end
					return abbreviate_name(git_blame_pl.get_current_blame_text()):lower()
				end,

				enabled = function()
					return G.gitblame_enabled ~= nil and G.gitblame_enabled
				end,

				right_sep = " ",
			}

			local function setup_navic()
				local highlight_groups = {
					"NavicIconsFile",
					"NavicIconsModule",
					"NavicIconsNamespace",
					"NavicIconsPackage",
					"NavicIconsClass",
					"NavicIconsMethod",
					"NavicIconsProperty",
					"NavicIconsField",
					"NavicIconsConstructor",
					"NavicIconsEnum",
					"NavicIconsInterface",
					"NavicIconsFunction",
					"NavicIconsVariable",
					"NavicIconsConstant",
					"NavicIconsString",
					"NavicIconsNumber",
					"NavicIconsBoolean",
					"NavicIconsArray",
					"NavicIconsObject",
					"NavicIconsKey",
					"NavicIconsNull",
					"NavicIconsEnumMember",
					"NavicIconsStruct",
					"NavicIconsEvent",
					"NavicIconsOperator",
					"NavicIconsTypeParameter",
					"NavicText",
					"NavicSeparator",
				}
				NavicOriginalHighlights = {}
				for _, group in ipairs(highlight_groups) do
					-- Get the current highlight settings for the group
					local current_settings = vim.api.nvim_get_hl(0, { name = group })
					NavicOriginalHighlights[group] = current_settings
				end

				-- Iterate over each highlight group and change the background color
				for group, current_settings in pairs(NavicOriginalHighlights) do
					-- Set the new background color while preserving other settings
					if current_settings.link == nil then
						vim.api.nvim_set_hl(
							0,
							group,
							vim.tbl_extend("force", current_settings, {
								bg = MyTheme.black,
							})
						)
					else
						local linked_settings = vim.api.nvim_get_hl(0, { name = current_settings.link })
						vim.api.nvim_set_hl(
							0,
							group,
							vim.tbl_extend("force", linked_settings, {
								bg = MyTheme.black,
							})
						)
					end
				end
			end

			setup_navic()

			local navic = require("nvim-navic")
			local navic_component = {
				provider = function()
					if not navic.is_available() then
						return "✨☆＊✧⋆"
					end
					local location = navic.get_location()
					if location ~= "" then
						return location
					end
					return "✨☆＊✧⋆"
				end,
				enabled = function()
					return true
				end,
				hl = function()
					return { bg = "black", fg = "fg" }
				end,
			}
			local empty = {
				provider = function()
					return ""
				end,
				enabled = function()
					return true
				end,
				hl = function()
					return { bg = "black", fg = "fg" }
				end,
			}

			local macro = {
				provider = "macro",
				hl = { fg = "red" },
				left_sep = "        ",
				right_sep = "        ",
			}

			local left = {
				file_name,
				file_line,
				vi_mode,
				macro,
			}

			local mid = {}

			local right = {
				search_count,
				diagnostic_errors,
				diagnostic_warnings,
				diagnostic_hints,
				diagnostic_info,
				git_branch,
				git_diff.add,
				git_diff.modify,
				git_diff.del,
				git_blame,
			}

			local components = {
				active = { left, mid, right },
				inactive = { left, mid, right },
			}

			local function setup_feline()
				require("feline").setup({
					components = components,
					theme = MyTheme,
					disable = { buftypes = { "terminal" }, filetypes = { "neo--tree", "^Outline$" } },
				})

				require("feline").winbar.setup({
					components = {
						active = { { empty }, { navic_component, empty }, { empty } },
						inactive = { { empty }, { navic_component, empty }, { empty } },
					},
					theme = MyTheme,
					disable = { buftypes = { "terminal" }, filetypes = { "neo--tree", "^Outline$" } },
				})
			end

			vim.api.nvim_create_autocmd({ "ColorScheme" }, {
				callback = function()
					vim.defer_fn(function()
						setup_theme()
						setup_navic()
						vim.cmd([[Lazy reload feline.nvim]])
						setup_feline()
					end, 100)
				end,
			})

			setup_feline()
		end,
	},
	{
		"romgrk/barbar.nvim",
		event = "VeryLazy",
		config = function()
			require("bufferline").setup()
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({})
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				css = { css = true },
			})
		end,
	},

	{
		"romgrk/barbar.nvim",
		event = "VeryLazy",
		config = function()
			require("bufferline").setup()
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({})
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				css = { css = true },
			})
		end,
	},

	{ "stevearc/dressing.nvim", event = "VeryLazy" },

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
	{
		"Shatur/neovim-session-manager",
		event = "VeryLazy",
		config = function()
			local Path = require("plenary.path")
			require("session_manager").setup({
				sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
				path_replacer = "__", -- The character to which the path separator will be replaced for session files.
				colon_replacer = "++", -- The character to which the colon symbol will be replaced for session files.
				autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
				autosave_last_session = true, -- Automatically save last session on exit and on session switch.
				autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
				autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
					"gitcommit",
				},
				autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
				max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
			})
		end,
	},

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
		event = "VeryLazy",
	},

	{ "f-person/git-blame.nvim", event = "VeryLazy" },

	-- neotree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			return function()
				-- If you want icons for diagnostic errors, you'll need to define them somewhere:
				vim.diagnostic.config({
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = " ",
							[vim.diagnostic.severity.WARN] = " ",
							[vim.diagnostic.severity.INFO] = " ",
							[vim.diagnostic.severity.HINT] = "󰌵",
						},
					},
				})

				require("neo-tree").setup({
					close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
					popup_border_style = "rounded",
					enable_git_status = true,
					enable_diagnostics = true,
					default_component_configs = {
						container = {
							enable_character_fade = true,
						},
						indent = {
							indent_size = 2,
							padding = 1, -- extra padding on left hand side
							-- indent guides
							with_markers = true,
							indent_marker = "│",
							last_indent_marker = "└",
							highlight = "NeoTreeIndentMarker",
							-- expander config, needed for nesting files
							with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
							expander_collapsed = "",
							expander_expanded = "",
							expander_highlight = "NeoTreeExpander",
						},
						icon = {
							folder_closed = "",
							folder_open = "",
							folder_empty = "󰜌",
							-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
							-- then these will never be used.
							default = "*",
							highlight = "NeoTreeFileIcon",
						},
						modified = {
							symbol = "[+]",
							highlight = "NeoTreeModified",
						},
						name = {
							trailing_slash = false,
							use_git_status_colors = true,
							highlight = "NeoTreeFileName",
						},
						git_status = {
							symbols = {
								-- Change type
								added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
								modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
								deleted = "✖", -- this can only be used in the git_status source
								renamed = "󰁕", -- this can only be used in the git_status source
								-- Status type
								untracked = "",
								ignored = "",
								unstaged = "󰄱",
								staged = "",
								conflict = "",
							},
						},
					},
					window = {
						position = "left",
						width = 40,
						mapping_options = {
							noremap = true,
							nowait = true,
						},
						mappings = {
							["<space>"] = {
								"toggle_node",
								nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
							},
							["o"] = "open",
							["t"] = "open_tabnew",
							["S"] = "open_split",
							["s"] = "open_vsplit",
							["w"] = "open_with_window_picker",
							["C"] = "close_node",
							["a"] = "add",
							["A"] = "add_directory",
							["d"] = "delete",
							["r"] = "rename",
							["y"] = "copy_to_clipboard",
							["x"] = "cut_to_clipboard",
							["p"] = "paste_from_clipboard",
							["c"] = "copy", -- takes text input for destination
							["m"] = "move", -- takes text input for destination
							["q"] = "close_window",
							["R"] = "refresh",
						},
					},
					nesting_rules = {},
					filesystem = {
						filtered_items = {
							visible = false, -- when true, they will just be displayed differently than normal items
							hide_dotfiles = true,
							hide_gitignored = true,
							hide_hidden = true, -- only works on Windows for hidden files/directories
							hide_by_name = {
								".DS_Store",
								"thumbs.db",
								--"node_modules"
							},
							hide_by_pattern = { -- uses glob style patterns
								--"*.meta"
							},
							never_show = { -- remains hidden even if visible is toggled to true
								--".DS_Store",
								--"thumbs.db"
							},
						},
						follow_current_file = { enabled = true }, -- This will find and focus the file in the active buffer every
						-- time the current file is changed while the tree is open.
						hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
						-- in whatever position is specified in window.position
						-- "open_current",  -- netrw disabled, opening a directory opens within the
						-- window like netrw would, regardless of window.position
						-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
						use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
						-- instead of relying on nvim autocmd events.
						window = {
							mappings = {
								["<bs>"] = "navigate_up",
								["."] = "set_root",
								["H"] = "toggle_hidden",
								["/"] = "fuzzy_finder",
								["f"] = "filter_on_submit",
								["<c-x>"] = "clear_filter",
							},
						},
					},
					buffers = {
						show_unloaded = true,
						window = {
							mappings = {
								["bd"] = "buffer_delete",
								["<bs>"] = "navigate_up",
								["."] = "set_root",
							},
						},
					},
					git_status = {
						window = {
							position = "float",
							mappings = {
								["A"] = "git_add_all",
								["gu"] = "git_unstage_file",
								["ga"] = "git_add_file",
								["gr"] = "git_revert_file",
								["gc"] = "git_commit",
								["gp"] = "git_push",
								["gg"] = "git_commit_and_push",
							},
						},
					},
				})
			end
		end,
		event = "VeryLazy",
	},

	-- autotag
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

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
	},

	{
		"SmiteshP/nvim-navbuddy",
		dependencies = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
			"nvim-telescope/telescope.nvim", -- Optional
		},
		event = "VeryLazy",
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

	-- {
	-- 	"simrat39/symbols-outline.nvim",
	-- 	config = function()
	-- 		require("symbols-outline").setup({
	-- 			-- use vscode icons
	-- 			symbols = {
	-- 				File = { icon = " ", hl = "@text.uri" },
	-- 				Module = { icon = " ", hl = "@namespace" },
	-- 				Namespace = { icon = " ", hl = "@namespace" },
	-- 				Package = { icon = " ", hl = "@namespace" },
	-- 				Class = { icon = " ", hl = "@type" },
	-- 				Method = { icon = " ", hl = "@method" },
	-- 				Property = { icon = " ", hl = "@method" },
	-- 				Field = { icon = " ", hl = "@field" },
	-- 				Constructor = { icon = " ", hl = "@constructor" },
	-- 				Enum = { icon = " ", hl = "@type" },
	-- 				Interface = { icon = " ", hl = "@type" },
	-- 				Function = { icon = " ", hl = "@function" },
	-- 				Variable = { icon = " ", hl = "@constant" },
	-- 				Constant = { icon = " ", hl = "@constant" },
	-- 				String = { icon = " ", hl = "@string" },
	-- 				Number = { icon = " ", hl = "@number" },
	-- 				Boolean = { icon = " ", hl = "@boolean" },
	-- 				Array = { icon = " ", hl = "@constant" },
	-- 				Object = { icon = " ", hl = "@type" },
	-- 				Key = { icon = " ", hl = "@type" },
	-- 				Null = { icon = " ", hl = "@type" },
	-- 				EnumMember = { icon = " ", hl = "@field" },
	-- 				Struct = { icon = " ", hl = "@type" },
	-- 				Event = { icon = " ", hl = "@type" },
	-- 				Operator = { icon = " ", hl = "@operator" },
	-- 				TypeParameter = { icon = " ", hl = "@parameter" },
	-- 				Component = { icon = " ", hl = "@function" },
	-- 				Fragment = { icon = " ", hl = "@constant" },
	-- 			},
	-- 		})
	-- 	end,
	-- },

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({ start_in_insert = false })
		end,
	},

	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
		},
		ft = { "sql", "plsql", "clickhouse" },
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

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			"zbirenbaum/copilot.lua", -- or github/copilot.vim
			{ "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		event = "VeryLazy",
	},

	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy",
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

	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = false, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					lsp_doc_border = true, -- add a border to hover docs and signature help
					inc_rename = true,
				},
				messages = {
					view = "mini",
					view_error = "mini",
					view_warning = "mini",
				},
			})
		end,
	},

	{
		"nvim-neotest/neotest",
		ft = { "python" },
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-neotest/neotest-python",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python")({
						args = { "--keepdb" },
						dap = { justMyCode = false },
						runner = "django",
					}),
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
