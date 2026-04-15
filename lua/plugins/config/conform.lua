return function()
	if vim.g.CONFORM_FORMAT_ON_SAVE == nil then
		vim.g.CONFORM_FORMAT_ON_SAVE = true
	end

	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			java = { "google-java-format", lsp_format = "fallback" },
			rust = { "rustfmt", lsp_format = "fallback" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
		},
		formatters = {
			["google-java-format"] = {
				prepend_args = { "--aosp" },
			},
		},
		--[[ Optional: Enable format-on-save
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		} ,]]
		format_on_save = function(bufnr)
			if not vim.g.CONFORM_FORMAT_ON_SAVE then
				return nil
			end
			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end,
	})
	local function set_format_on_save(enabled)
		vim.g.CONFORM_FORMAT_ON_SAVE = enabled
		vim.notify("Format on save: " .. (enabled and "ON" or "OFF"), vim.log.levels.INFO)
	end

	vim.api.nvim_create_user_command("ConformAutoFormatToggle", function()
		set_format_on_save(not vim.g.CONFORM_FORMAT_ON_SAVE)
	end, { desc = "Toggle conform format on save" })

	vim.api.nvim_create_user_command("ConformAutoFormatOn", function()
		set_format_on_save(true)
	end, { desc = "Enable conform format on save" })

	vim.api.nvim_create_user_command("ConformAutoFormatOff", function()
		set_format_on_save(false)
	end, { desc = "Disable conform format on save" })
end
