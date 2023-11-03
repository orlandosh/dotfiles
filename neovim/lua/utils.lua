local utils = { get_dir = function() end }

utils.get_dir = function()
	local handle = io.popen("echo $PWD")
	local dir = handle:read("*a")
	handle:close()

	return dir:gsub("\n", "") .. "/"
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

utils.get_json = function(path)
	local file = io.open(path, "r")

	if not file then
		return {}
	end

	local content = file:read("*a")
	file:close()
	return vim.json.decode(content) or {}
end

utils.work_keyword = "work"

return utils
