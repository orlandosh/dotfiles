local iron = require("iron.core")

iron.setup({
	config = {
		-- If iron should expose `<plug>(...)` mappings for the plugins
		should_map_plug = false,
		-- Whether a repl should be discarded or not
		scratch_repl = true,
		close_window_on_exit = true,
		-- Your repl definitions come here
		repl_definition = {
			sh = {
				command = { "zsh" },
			},
			-- python = { command = { "ipython" } },
		},
	},
	repl_open_cmd = require("iron.view").curry.right(20),
	-- Iron doesn't set keymaps by default anymore. Set them here
	-- or use `should_map_plug = true` and map from you vim files
	keymaps = {
		send_motion = "<leader>sc",
		visual_send = "<leader>sc",
		send_line = "<leader>sl",
		repeat_cmd = "<leader>s.",
		exit = "<leader>sq",
		clear = "<leader>cl",
	},
})
