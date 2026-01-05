return function()
	require("lualine").setup({
		options = {
			theme = "catppuccin-mocha",
			component_separators = { left = "│", right = "│" },
			section_separators = { left = "", right = "" },
			globalstatus = true, -- optional: single bar across the bottom
		},
		sections = {
			lualine_a = {
				{ "mode", separator = { left = "" }, right_padding = 2 },
			},
			lualine_b = {
				"filename",
				"branch",
			},
			lualine_c = {
				"fileformat",

				-- DAP stepping mode indicator
				function()
					if _G.dap_step_mode_status then
						return _G.dap_step_mode_status()
					end
					return ""
				end,
			},
			lualine_x = {},
			lualine_y = { "filetype", "progress" },
			lualine_z = {
				{ "location", separator = { right = "" }, left_padding = 2 },
			},
		},
		inactive_sections = {

			lualine_a = { "filename" },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { "location" },
		},
		tabline = {},
		extensions = {},
	})
end
