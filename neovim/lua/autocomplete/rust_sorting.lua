-- MIT License

-- Copyright (c) 2023 Ryo Hirayama

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-- changes to the program: replace .iter() and add IntoSql

local function deprioritize_postfix(entry1, entry2)
	local kind1 = entry1:get_kind()
	local kind2 = entry2:get_kind()
	-- if one of them is nil, compare is pointless
	if kind1 ~= kind2 then
		-- 15 is text
		if kind1 == 15 then
			return false
		end
		if kind2 == 15 then
			return true
		end
	end
end

local function deprioritize_common_traits(entry1, entry2)
	local function is_common_trait(entry)
		local label = entry.completion_item.label
		if label == nil then
			return false
		end
		-- find `(as Trait)` in the label
		local trait = label:match("%(as ([^)]+)%)")
		if trait == nil then
			return false
		end
		local traits = {
			"Clone",
			"Copy",
			"Deref",
			"DerefMut",
			"Borrow",
			"BorrowMut",
			"Drop",
			"ToString",
			"ToOwned",
			"PartialEq",
			"PartialOrd",
			"AsRef",
			"AsMut",
			"From",
			"Into",
			"TryFrom",
			"TryInto",
			"Default",
			"IntoSql",
		}

		for i, v in ipairs(traits) do
			if v == trait then
				return true
			end
		end

		return false
	end
	local is_common_1 = is_common_trait(entry1)
	local is_common_2 = is_common_trait(entry2)
	if is_common_1 ~= is_common_2 then
		return not is_common_1
	end
end

local function deprioritize_borrow(entry1, entry2)
	local function has_borrow(entry)
		local label = entry.completion_item.label
		if label == nil then
			return false
		end
		-- find `(use ...)` in the label
		return label:match("%(use %a+::borrow::Borrow") ~= nil
	end
	local use1 = has_borrow(entry1)
	local use2 = has_borrow(entry2)
	if use1 ~= use2 then
		return not use1
	end
end

local function deprioritize_deref(entry1, entry2)
	local function has_deref(entry)
		local label = entry.completion_item.label
		if label == nil then
			return false
		end
		return label:match("Deref") ~= nil
	end
	local use1 = has_deref(entry1)
	local use2 = has_deref(entry2)
	if use1 ~= use2 then
		return not use1
	end
end

return {
	deprioritize_postfix = deprioritize_postfix,
	deprioritize_common_traits = deprioritize_common_traits,
	deprioritize_borrow = deprioritize_borrow,
	deprioritize_deref = deprioritize_deref,
}
