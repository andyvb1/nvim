return function()
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
		-- Optional: Enable format-on-save
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	})
end
