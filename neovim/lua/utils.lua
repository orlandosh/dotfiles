local utils = { get_dir = function() end }

utils.get_dir = function()
	local handle = io.popen("echo $PWD")
	local dir = handle:read("*a")
	handle:close()

	return dir
end

return utils
