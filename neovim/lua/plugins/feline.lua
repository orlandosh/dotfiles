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

local function abbreviate_name(blame_text)
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
		if (G.gitblame_enabled ~= nil and G.gitblame_enabled == 0) or not git_blame_pl.is_blame_text_available() then
			return ""
		end
		return abbreviate_name(git_blame_pl.get_current_blame_text()):lower()
	end,

	enabled = function()
		return G.gitblame_enabled ~= nil and G.gitblame_enabled > 0
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

require("feline").setup({
	components = components,
	theme = require("plugins.feline.theme").my_theme,
	disable = { buftypes = { "terminal" }, filetypes = { "neo--tree" } },
})
