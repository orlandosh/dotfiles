local utils = { get_dir = function() end }

utils.get_dir = function()
	local handle = io.popen("echo $PWD")
	local dir = handle:read("*a")
	handle:close()

	return dir
end

utils.copy_table = function(t)
	local t2 = {}
	for k, v in pairs(t) do
		t2[k] = v
	end
	return t2
end

return utils
