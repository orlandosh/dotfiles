local lint = { lint = require("lint") }

local pylint = require("lint.linters.pylint")

local bufdir = require("utils").get_dir()

if bufdir:find("apicbase") or bufdir:find("dango") then
	pylint.cmd = "poetry"
	pylint.args = {
		"run",
		"pylint",
		unpack(pylint.args),
	}
end

local python_linters = { "pylint" }
if string.find(bufdir, "apicbase") then
	table.insert(python_linters, "flake8")
end

return lint
