local fe_vi_mode = require("feline.providers.vi_mode")
local fe_file = require("feline.providers.file")
local fe_git = require("feline.providers.git")
local fe_cursor = require("feline.providers.cursor")

local file_name = {
	provider = function()
		local file_name, icon = fe_file.file_info({}, { unique = true })
		return file_name .. ":" .. fe_cursor.position({}, {}), icon
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

-- TODO: highlight feature, hotfix, etc
local git_branch = { provider = { name = "git_branch" }, right_sep = " ", hl = function() end }

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
		return { fg = "yellow" }
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

local left = {
	file_name,
	file_line,
	vi_mode,
}

local mid = {}

local right = {
	git_branch,
	git_diff.add,
	git_diff.modify,
	git_diff.del,
}

local components = {
	active = { left, mid, right },
	inactive = { left, mid, right },
}

require("feline").setup({ components = components, theme = require("plugins.feline.theme").my_theme })
