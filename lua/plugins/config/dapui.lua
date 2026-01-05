return function()
	local dapui = require("dapui")
	local dap = require("dap")

	dapui.setup({
		focus_console = true,
		layouts = {
			{
				elements = {
					{ id = "scopes", size = 0.25 },
					{ id = "breakpoints", size = 0.25 },
					{ id = "stacks", size = 0.25 },
					{ id = "watches", size = 0.25 },
				},
				size = 40,
				position = "left",
			},
			{
				elements = {
					{ id = "console", size = 1, enter = true },
				},
				size = 15,
				position = "bottom",
			},
		},
	})

	-- Auto-open/close UI when debugging starts/stops
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		print("Session terminated", vim.inspect(session), vim.inspect(body))
		--dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		print("Session terminated", vim.inspect(session), vim.inspect(body))
		--dapui.close()
	end

	-- Keybind to manually toggle UI
	vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
end
