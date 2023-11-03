local lint = { lint = require("lint") }

local pylint = require("lint.linters.pylint")

local bufdir = require("utils").get_dir()
local work_keyword = require("utils").work_keyword

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
