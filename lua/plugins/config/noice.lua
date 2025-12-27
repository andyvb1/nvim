return function()
    require("noice").setup({
        cmdline = {
            view = "cmdline_popup",
            format = {
                search_down = { view = "cmdline_popup" },
                search_up = { view = "cmdline_popup" },
            },
        },
        views = {
            cmdline_popup = {
                position = { row = "50%", col = "50%" },
                size = { width = 60, height = "auto" },
            },
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = false,
            command_palette = false,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = false,
        },
    })
end
