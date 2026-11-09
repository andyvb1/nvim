return function()
	require("which-key").setup({
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
			presets = {
				operators = true,
				motions = true,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
		},
		keys = {
			scroll_down = "<c-d>",
			scroll_up = "<c-u>",
		},
		win = {
			border = "none",
			padding = { 1, 2 },
			zindex = 1000,
			wo = {
				winblend = 60,
			},
		},
	})
end
