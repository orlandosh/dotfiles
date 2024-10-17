return {
	"rcarriga/nvim-dap-ui",
	lazy = true,
	event = "VeryLazy",
	dependencies = {
		{ "mfussenegger/nvim-dap", lazy = true, event = "VeryLazy" },
		{ "mfussenegger/nvim-dap-python", lazy = true, event = "VeryLazy" },
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
		require("dap-python").setup(path)

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		dapui.setup()
		dap.set_log_level("TRACE")

		local pythonAttachConfig = {
			type = "python",
			request = "launch",
			name = "Django",
			cwd = vim.fn.getcwd(),
			program = vim.fn.getcwd() .. "/manage.py", -- NOTE: Adapt path to manage.py as needed
			args = { "runserver", "10.111.111.2:8000" },
		}
		table.insert(require("dap").configurations.python, pythonAttachConfig)

		-- change Breakpoint icon
		vim.fn.sign_define("DapBreakpoint", {
			text = "🅑 ",
			texthl = "",
			linehl = "",
			numhl = "",
		})

		require("dap-python").resolve_python = function()
			-- Run the poetry command
			local handle = io.popen("poetry env info --path")
			local result = handle:read("*a")
			handle:close()

			-- Trim any trailing whitespace/newlines
			result = result:gsub("%s+$", "")

			-- Return the absolute path
			return result .. "/bin/python"
		end
	end,
}
