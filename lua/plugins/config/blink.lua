return function()
	require("blink.cmp").setup({
		keymap = {
			preset = "none",
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-y>"] = { "select_and_accept", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			["<C-n>"] = { "select_next", "fallback_to_mappings" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},
		completion = {
			list = {
				selection = {
					preselect = false,
					auto_insert = false,
				},
			},
			menu = {
				border = "rounded",
				winblend = 33,
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", gap = 1 },
						{ "label_description" },
					},
				},
			},
			documentation = {
				auto_show = true,
				window = { border = "rounded" },
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		snippets = { preset = "default" },
		cmdline = {
			keymap = { preset = "cmdline" },
			completion = {
				list = {
					selection = {
						preselect = false,
					},
				},
				menu = { auto_show = true },
			},
			sources = function()
				local type = vim.fn.getcmdtype()
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				return { "path", "cmdline" }
			end,
		},
	})
end
