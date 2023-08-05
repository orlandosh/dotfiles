local utils = { get_dir = function() end }

utils.get_dir = function()
	local handle = io.popen("echo $PWD")
	local dir = handle:read("*a")
	handle:close()

	return dir
end

utils.copy_table = function(original)
	local lookup_table = {}

	local function _copy(original)
		if type(original) ~= "table" then
			return original
		elseif lookup_table[original] then
			return lookup_table[original]
		end

		local new_table = {}
		lookup_table[original] = new_table

		for key, value in pairs(original) do
			new_table[_copy(key)] = _copy(value)
		end

		return setmetatable(new_table, _copy(getmetatable(original)))
	end

	return _copy(original)
end
return utils
