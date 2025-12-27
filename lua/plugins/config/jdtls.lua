return function()
    local jdtls = require("jdtls")
    local jdtls_dap = require("jdtls.dap")

    -- Disable the builtin jdtls autostart (from vim.lsp.config) since we manage startup manually.
    pcall(function()
        vim.lsp.enable("jdtls", false)
    end)

    local root_markers = {
        "settings.gradle",
        "settings.gradle.kts",
        "pom.xml",
        "build.gradle",
        "build.gradle.kts",
        "mvnw",
        "gradlew",
    }

    local root_dir = jdtls.setup.find_root(root_markers)
    if not root_dir or root_dir == vim.env.HOME then
        root_dir = vim.fn.getcwd()
    end

    local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
    local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

    local runtimes = {
        {
            name = "default",
            path = "/usr/lib/jvm/default",
            default = true,
        },
        {
            name = "JavaSE-25",
            path = "/usr/lib/jvm/java-25-openjdk",
        },
        {
            name = "JavaSE-11",
            path = "/usr/lib/jvm/java-11-openjdk",
        },
        {
            name = "JavaSE-8",
            path = "/usr/lib/jvm/java-8-openjdk",
        },
    }

    local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
    local java_debug_path = mason_path .. "/java-debug-adapter/extension/server"
    local java_test_path = mason_path .. "/java-test/extension/server"

    local function get_bundles()
        local bundles = {}

        local debug_jar = vim.fn.glob(java_debug_path .. "/com.microsoft.java.debug.plugin-*.jar", true)
        if debug_jar ~= "" then
            table.insert(bundles, debug_jar)
        end

        local test_jars = vim.split(vim.fn.glob(java_test_path .. "/*.jar", true), "\n")
        for _, jar in ipairs(test_jars) do
            if jar ~= "" then
                table.insert(bundles, jar)
            end
        end

        return bundles
    end

    local jdtls_config = {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls", "-data", workspace_dir },
        root_dir = root_dir,
        settings = {
            java = {
                inlayHints = { parameterNames = { enabled = "all" } },
                configuration = {
                    updateBuildConfiguration = "disabled",
                    runtimes = runtimes,
                },
                import = {
                    exclusions = {
                        "**/node_modules/**",
                        "**/.metadata/**",
                        "**/archetype-resources/**",
                        "**/META-INF/maven/**",
                        vim.env.HOME .. "/**",
                    },
                },
            },
        },
        init_options = {
            bundles = get_bundles(),
        },
        on_attach = function(_, _)
            -- LSP-only attach; DAP handled globally in dap_setup
        end,
    }

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
            jdtls.start_or_attach(jdtls_config)
        end,
    })

    local function set_java_runtime(name)
        for _, rt in ipairs(runtimes) do
            rt.default = (rt.name == name)
        end

        for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            if client.name == "jdtls" then
                client.notify("workspace/didChangeConfiguration", {
                    settings = {
                        java = {
                            configuration = {
                                runtimes = runtimes,
                            },
                        },
                    },
                })
                vim.notify("Switched Java runtime to " .. name, vim.log.levels.INFO)
                return
            end
        end
        vim.notify("No active jdtls client found", vim.log.levels.WARN)
    end

    vim.api.nvim_create_user_command("JavaSetRuntime", function(opts)
        set_java_runtime(opts.args)
    end, {
        nargs = 1,
        complete = function()
            return vim.tbl_map(function(rt)
                return rt.name
            end, runtimes)
        end,
    })
end
