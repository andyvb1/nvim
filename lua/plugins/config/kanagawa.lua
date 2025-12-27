return function()
    require("kanagawa").setup({
        compile = true,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true,
        dimInactive = false,
        terminalColors = true,
        colors = {
            palette = {},
            theme = {
                wave = {},
                lotus = {},
                dragon = {
                    ui = {
                        bg_gutter = "none",
                    },
                },
                all = {
                    ui = {
                        bg_gutter = "none",
                    },
                },
            },
        },
        overrides = function(_)
            return {}
        end,
        theme = "dragon",
    })
end
