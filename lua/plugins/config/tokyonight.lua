return function()
	require("tokyonight").setup({
		-- Theme style.
		--
		-- Possible values:
		--   "storm" = darker blue variant
		--   "night" = darkest variant
		--   "moon"  = default, balanced dark variant
		--   "day"   = light variant
		--
		-- NOTE: The upstream comment currently says "three styles", but
		-- `moon` is also a valid/default style in the current release.
		style = "storm",

		-- Theme to use automatically when `:set background=light`.
		--
		-- Possible values:
		--   "day"
		light_style = "day",

		-- Don't set the background color.
		--
		-- false = use TokyoNight's normal background
		-- true  = transparent background
		transparent = true,

		-- Configure terminal colors.
		--
		-- false = don't configure terminal colors
		-- true  = configure colors used by :terminal
		terminal_colors = true,

		styles = {
			-- Syntax-group styling.
			--
			-- Values can be any valid Neovim highlight attributes accepted by
			-- nvim_set_hl(), for example:
			--   italic = true/false
			--   bold = true/false
			--   underline = true/false
			--   undercurl = true/false
			--   reverse = true/false
			--   strikethrough = true/false
			--   fg = "#rrggbb"
			--   bg = "#rrggbb"
			--
			comments = {
				italic = true,
			},

			keywords = {
				italic = true,
			},

			functions = {},

			variables = {},

			-- Background style for sidebar-type windows.
			--
			-- Possible values:
			--   "dark"
			--   "transparent"
			--   "normal"
			sidebars = "transparent",

			-- Background style for floating windows.
			--
			-- Possible values:
			--   "dark"
			--   "transparent"
			--   "normal"
			floats = "transparent",
		},

		-- Brightness adjustment for the `day` style.
		--
		-- Range: 0 to 1
		--
		-- 0 = duller
		-- 1 = more vibrant
		day_brightness = 0.6,

		-- Dim inactive windows.
		--
		-- false = don't dim inactive windows
		-- true  = dim inactive windows
		dim_inactive = false,

		-- Make Lualine section headers bold.
		--
		-- false = normal weight
		-- true  = bold
		lualine_bold = false,

		-- Override colors from TokyoNight's ColorScheme.
		--
		-- `colors` contains TokyoNight's generated color palette.
		--
		-- Example:
		--
		-- on_colors = function(colors)
		--   colors.bg = "#000000"
		--   colors.fg = "#ffffff"
		-- end,
		on_colors = function(colors) end,

		-- Override generated highlight groups.
		--
		-- `highlights` contains TokyoNight's highlight definitions.
		-- `colors` contains the generated color palette.
		--
		-- Example:
		--
		-- on_highlights = function(highlights, colors)
		--   highlights.Normal = {
		--     bg = "#000000",
		--   }
		--
		--   highlights.Comment = {
		--     fg = colors.comment,
		--     italic = false,
		--   }
		-- end,
		on_highlights = function(highlights, colors) end,

		-- Cache the generated theme.
		--
		-- false = regenerate the theme each time
		-- true  = cache it for better startup/performance
		cache = true,

		plugins = {
			-- Enable every supported TokyoNight plugin integration when
			-- not using lazy.nvim.
			--
			-- Automatically evaluates to:
			--   true  when lazy.nvim is NOT loaded
			--   false when lazy.nvim IS loaded
			--
			-- Set individual integrations manually if desired.
			all = package.loaded.lazy == nil,

			-- Automatically enable integrations required by your plugin manager.
			--
			-- Currently supported:
			--   true/false
			--
			-- TokyoNight currently supports automatic integration with
			-- lazy.nvim.
			auto = true,

			-- Explicitly enable additional plugin integrations.
			--
			-- Any supported plugin can be added here:
			--
			--   telescope = true,
			--   nvim_tree = true,
			--   which_key = true,
			--
			-- Set an integration to false to disable it:
			--
			--   telescope = false,
			--
			-- See the complete list:
			-- https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
		},
	})
end
