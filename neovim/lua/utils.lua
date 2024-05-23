local utils = { get_dir = function() end }

utils.get_dir = function()
	local handle = io.popen("echo $PWD")
	if handle ~= nil then
		local dir = handle:read("*a")
		handle:close()

		return dir:gsub("\n", "") .. "/"
	end

	return ""
end

utils.copy_table = function(original)
	local lookup_table = {}

	local function _copy(_original)
		if type(_original) ~= "table" then
			return _original
		elseif lookup_table[_original] then
			return lookup_table[_original]
		end

		local new_table = {}
		lookup_table[_original] = new_table

		for key, value in pairs(_original) do
			new_table[_copy(key)] = _copy(value)
		end

		return setmetatable(new_table, _copy(getmetatable(_original)))
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

utils.file_exists = function(path)
	local file = io.open(path, "r")
	if file then
		file:close()
		return true
	end
	return false
end

utils.WORK_KEYWORD = "work"

return utils
