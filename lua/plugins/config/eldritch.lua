return function()
    require("eldritch").setup({
        transparent = true,
        terminal_colors = true,
        styles = {
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
            sidebars = "dark",
            floats = "dark",
        },
        sidebars = { "qf", "help" },
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = true,
        on_colors = function(_) end,
        on_highlights = function(_, _) end,
    })
end
