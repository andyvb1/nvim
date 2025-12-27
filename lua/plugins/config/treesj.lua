return function()
    require("treesj").setup({
        use_default_keymaps = false,
        check_syntax_error = false,
        max_join_length = 120,
        cursor_behavior = "hold",
        notify = true,
        langs = {
            lua = require("treesj.langs.lua"),
            typescript = require("treesj.langs.typescript"),
        },
        dot_repeat = true,
    })
end
