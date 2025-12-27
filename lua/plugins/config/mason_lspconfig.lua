return function()
    require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "rust_analyzer", "jdtls", "eslint" },
        automatic_enable = {
            exclude = { "jdtls" },
        },
    })
end
