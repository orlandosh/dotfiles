local pylint = require("lint.linters.pylint")
pylint.cmd = "poetry"
pylint.args = {
	"run",
	"pylint",
	unpack(pylint.args),
}
local linters = { "pylint" }
local handle = io.popen("echo $PWD")
local bufdir = handle:read("*a")
handle:close()
if string.find(bufdir, "apicbase") then
	table.insert(linters, "flake8")
end

require("lint").linters_by_ft = {
	python = linters,
}
