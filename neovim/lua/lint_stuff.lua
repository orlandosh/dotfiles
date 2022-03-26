local pylint = require("lint.linters.pylint")
pylint.cmd = "poetry"
pylint.args = {
	"run",
	"pylint",
	unpack(pylint.args),
}
local linters = { "pylint" }
local bufdir = vim.api.nvim_buf_get_name(0)
if string.find(bufdir, "apicbase") then
	table.insert(linters, "flake8")
end

require("lint").linters_by_ft = {
	python = linters,
}
