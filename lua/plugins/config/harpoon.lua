return function()
    require("harpoon").setup({
        global_settings = {
            save_on_toggle = false,
            save_on_change = true,
            enter_on_sendcmd = false,
            tmux_autoclose_windows = false,
            excluded_filetypes = { "harpoon" },
            mark_branch = true,
            tabline = false,
            tabline_prefix = "   ",
            tabline_suffix = "   ",
        },
    })

    pcall(function()
        require("telescope").load_extension("harpoon")
    end)
end
