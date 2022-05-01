local fe_vi_mode = require("feline.providers.vi_mode")
local fe_file = require("feline.providers.file")
local fe_git = require("feline.providers.git")
local fe_cursor = require("feline.providers.cursor")

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

		percent = percent:format("%-4s", percent) .. "%%"
		local pos_percent = string.format("%-16s", pos .. ":" .. percent)

		local icon_str, icon_color = require("nvim-web-devicons").get_icon_colors_by_filetype(
			vim.bo.filetype,
			{ default = true }
		)

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

local diagnostic_errors = { provider = "diagnostic_errors", hl = { fg = "magenta" }, right_sep = " " }
local diagnostic_warnings = { provider = "diagnostic_warnings", hl = { fg = "yellow" }, right_sep = " " }
local diagnostic_hints = { provider = "diagnostic_hints", hl = { fg = "cyan" }, right_sep = " " }
local diagnostic_info = { provider = "diagnostic_info", hl = { fg = "white" }, right_sep = " " }

local left = {
	file_name,
	file_line,
	vi_mode,
}

local mid = {}

local right = {
	diagnostic_errors,
	diagnostic_warnings,
	diagnostic_hints,
	diagnostic_info,
	git_branch,
	git_diff.add,
	git_diff.modify,
	git_diff.del,
}

local components = {
	active = { left, mid, right },
	inactive = { left, mid, right },
}

require("feline").setup({
	components = components,
	theme = require("plugins.feline.theme").my_theme,
	disable = { buftypes = { "terminal" }, filetypes = { "neo-tree" } },
})
