return function()
	require("solarized-osaka").setup({
		-- your configuration comes here
		-- or leave it empty to use the default settings
		style = "", -- The default dark style. Set to `vivid` for a higher-contrast variant that stays readable in bright environments
		light_style = "light", -- The theme is used when the background is set to light
		transparent = true, -- Enable this to disable setting the background color
		terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
		styles = {
			-- Style to be applied to different syntax groups
			-- Value is any valid attr-list value for `:help nvim_set_hl`
			comments = { italic = true },
			keywords = { italic = true },
			functions = {},
			variables = {},
			-- Background styles. Can be "dark", "transparent" or "normal"
			sidebars = "transparent", -- style for sidebars, see below
			floats = "transparent", -- style for floating windows
		},

		sidebars = { "qf", "help", "filesystem" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
		vivid_brightness = 0.5, -- Adjusts how far the **Vivid** style brightens text colors. Number between 0 and 1, from the default palette to white
		hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
		dim_inactive = false, -- dims inactive windows
		lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

		--- You can override specific color groups to use other groups or a hex color
		--- function will be called with a ColorScheme table
		---@param colors ColorScheme
		on_colors = function(colors) end,

		--- You can override specific highlights to use other groups or a hex color
		--- function will be called with a Highlights and ColorScheme table
		---@param highlights Highlights
		---@param colors ColorScheme
		on_highlights = function(hl, colors) end,
	})
end
