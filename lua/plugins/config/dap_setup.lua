return function()
	local dap = require("dap")
	local masonBin = vim.fn.stdpath("data") .. "/mason/bin"

	local jdtls = require("jdtls")
	local jdtls_dap = require("jdtls.dap")

	local dap_icons = {
		step_over = "",
		step_into = "",
		step_out = "",
		continue = "",
		breakpoint = "",
	}

	local debug_mode = {
		active = false,
		bufnr = nil,
	}

	_G.dap_step_mode_status = function()
		if not _G._dap_step_mode_active then
			return ""
		end

		return table.concat({
			"DAP",
			"z:" .. dap_icons.step_over,
			"x:" .. dap_icons.step_into,
			"c:" .. dap_icons.step_out,
			"v:" .. dap_icons.continue,
			"b:" .. dap_icons.breakpoint,
		}, " ")
	end

	local function disable_debug_mode()
		if not debug_mode.active then
			return
		end

		local keys = { "z", "x", "c", "v", "b", "<Esc>" }
		for _, key in ipairs(keys) do
			pcall(vim.api.nvim_buf_del_keymap, debug_mode.bufnr, "n", key)
		end

		debug_mode.active = false
		debug_mode.bufnr = nil
		_G._dap_step_mode_active = false

		vim.cmd("redrawstatus")
		vim.notify("DAP mode OFF", vim.log.levels.INFO)
	end

	local function enable_debug_mode()
		if debug_mode.active then
			return
		end

		debug_mode.active = true
		debug_mode.bufnr = vim.api.nvim_get_current_buf()
		_G._dap_step_mode_active = true

		local opts = { noremap = true, silent = true, buffer = debug_mode.bufnr }

		vim.keymap.set("n", "z", dap.step_over, opts)
		vim.keymap.set("n", "x", dap.step_into, opts)
		vim.keymap.set("n", "c", dap.step_out, opts)
		vim.keymap.set("n", "v", dap.continue, opts)
		vim.keymap.set("n", "b", dap.toggle_breakpoint, opts)
		vim.keymap.set("n", "<Esc>", disable_debug_mode, opts)

		vim.cmd("redrawstatus")
		vim.notify("DAP mode ON", vim.log.levels.INFO)
	end

	-- Export for which-key / external keymap files
	_G.dap_enable_step_mode = enable_debug_mode
	_G.dap_disable_step_mode = disable_debug_mode

	--- Auto-cleanup when debug session ends
	dap.listeners.before.event_terminated["dap_mode"] = disable_debug_mode
	dap.listeners.before.event_exited["dap_mode"] = disable_debug_mode

	--- Python (debugpy)
	dap.configurations.python = {
		{
			type = "debugpy",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			pythonPath = function()
				return "/usr/bin/python"
			end,
		},
	}

	--- Rust (codelldb)
	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			command = masonBin .. "/codelldb",
			args = { "--port", "${port}" },
		},
	}
	dap.configurations.rust = {
		{
			name = "Rust debug (cargo build)",
			type = "codelldb",
			request = "launch",
			program = function()
				-- run cargo build
				vim.fn.system({ "cargo", "build" })

				-- get crate name from Cargo.toml
				local crate = vim.fn
					.system([[cargo metadata --no-deps --format-version=1 | jq -r '.packages[0].name']])
					:gsub("%s+", "")

				return vim.fn.getcwd() .. "/target/debug/" .. crate
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			env = {
				RUST_BACKTRACE = "1",
			},
		},
		{
			name = "Rust debug (manual binary)",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			env = {
				RUST_BACKTRACE = "1",
			},
		},
	}
	--- Java (jdtls)
	local function setup_java_dap()
		jdtls.setup_dap({ hotcodereplace = "auto" })
		jdtls_dap.setup_dap_main_class_configs()
	end

	dap.listeners.after.event_initialized["java_dap"] = function()
		if vim.bo.filetype == "java" then
			setup_java_dap()
		end
	end

	---
end
