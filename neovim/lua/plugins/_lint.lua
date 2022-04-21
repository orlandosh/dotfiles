local pylint = require("lint.linters.pylint")

pylint.cmd = "poetry"
pylint.args = {
	"run",
	"pylint",
	unpack(pylint.args),
}

local bufdir = require("utils").get_dir()

local linters = { "pylint" }
if string.find(bufdir, "apicbase") then
	table.insert(linters, "flake8")
end

require("lint").linters_by_ft = {
	python = linters,
}
