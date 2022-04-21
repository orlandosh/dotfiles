-- Notes:
-- As per documentation, neotree configs are inside packer.lua

require("plugins.packer")
require("plugins.plain_setups")

require("plugins.autopairs")
require("plugins.autosave")
require("plugins.indent_blankline")
require("plugins._lint") -- we need to rename lint to _lint cause its also used in autocmd.lua
require("plugins.sessions")
require("plugins.telescope")
require("plugins.trouble")
