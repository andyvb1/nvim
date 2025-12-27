return function()
    require("telescope").setup({
        pickers = {
            find_files = { theme = "dropdown" },
            live_grep = { theme = "dropdown" },
            help_tags = { theme = "dropdown" },
        },
    })
end
