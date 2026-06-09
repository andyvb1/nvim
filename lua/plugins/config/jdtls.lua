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
		"gradlew",
		"mvnw",
		"pom.xml",
		"build.gradle",
		"build.gradle.kts",
	}

	local root_dir = jdtls.setup.find_root(root_markers)
	if not root_dir or root_dir == vim.env.HOME then
		root_dir = vim.fn.getcwd()
	end

	local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
	local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls-workspaces/" .. project_name

	local runtimes = {
		{
			name = "default",
			path = "/usr/lib/jvm/default",
		},
		{
			name = "JavaSE-25",
			path = "/usr/lib/jvm/java-25-openjdk",
		},
		{
			name = "JavaSE-21",
			path = "/usr/lib/jvm/java-21-openjdk",
		},
		{
			name = "JavaSE-17",
			path = "/usr/lib/jvm/java-17-openjdk",
		},
		{
			name = "JavaSE-11",
			path = "/usr/lib/jvm/java-11-openjdk",
			default = true,
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

		local lombok_jar = vim.fn.glob(mason_path .. "/jdtls/lombok.jar", true)
		if lombok_jar ~= "" then
			table.insert(bundles, lombok_jar)
		end

		local debug_jar = vim.fn.glob(java_debug_path .. "/com.microsoft.java.debug.plugin-*.jar", true)
		if debug_jar ~= "" then
			table.insert(bundles, debug_jar)
		end

		local test_jars = vim.split(vim.fn.glob(java_test_path .. "/*.jar", true), "\n")
		for _, jar in ipairs(test_jars) do
			if jar ~= "" and not jar:match("jacocoagent") then
				table.insert(bundles, jar)
			end
		end

		return bundles
	end

	local completion = {
		favoriteStaticMembers = {
			-- JUnit 5 Assertions
			"org.junit.jupiter.api.Assertions.*",
			"org.junit.jupiter.api.Assumptions.*",
			"org.junit.jupiter.api.DynamicContainer.*",
			"org.junit.jupiter.api.DynamicTest.*",

			-- Mockito
			"org.mockito.Mockito.*",
			"org.mockito.ArgumentMatchers.*",
			"org.mockito.Answers.*",

			-- AssertJ (Preferred for Spring Boot)
			"org.assertj.core.api.Assertions.*",

			-- Spring Test & MVC Matchers
			"org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
			"org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
			"org.springframework.test.web.servlet.setup.MockMvcBuilders.*",

			-- Hamcrest
			"org.hamcrest.Matchers.*",
			"org.hamcrest.CoreMatchers.*",

			-- Java Utils
			"java.util.Objects.requireNonNull",
			"java.util.Objects.requireNonNullElse",
		},
	}

	local jdtls_config = {
		cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls", "-data", workspace_dir },
		root_dir = root_dir,
		settings = {
			java = {
				completion = completion,
				--[[
                format = {
                    --using conform with google-java-style but this is backup
                    enabled = true,
                    url = vim.fn.expand("~/.config/nvim/lua/formatter/eclipse-java-google-style.xml"),
                    profile = "GoogleStyle", -- Must match the <profile name="..."> in the X
                },]]
				inlayHints = { parameterNames = { enabled = "all" } },
				configuration = {
					updateBuildConfiguration = "interactive",
					runtimes = runtimes,
				},
				import = {
					gradle = {
						enabled = true,
						wrapper = {
							enabled = true,
						},
					},
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
			jdtls.update_project_config()
		end,
	}

	vim.list_extend(jdtls_config.init_options.bundles, require("spring_boot").java_extensions())

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "java",
		callback = function()
			jdtls.start_or_attach(jdtls_config)
		end,
	})

	--[[
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
	})]]
end
