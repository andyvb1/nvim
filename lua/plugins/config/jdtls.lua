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

	-- Per-project runtime override
	-- Reads an optional <root_dir>/.nvim-jdtls.json of the form:
	--   { "runtime": "JavaSE-21" }
	local function read_project_runtime(root)
		local conf_path = root .. "/.nvim-jdtls.json"
		local file = io.open(conf_path, "r")
		if not file then
			vim.notify("No project runtime config file: " .. conf_path, vim.log.levels.INFO)
			return nil
		end
		local src = file:read("*a")
		file:close()

		local ok, decoded = pcall(vim.json.decode, src)
		if not ok then
			vim.notify(".nvim-jdtls.json: invalid JSON: " .. tostring(decoded), vim.log.levels.WARN)
			return nil
		end

		if type(decoded) ~= "table" or type(decoded.runtime) ~= "string" then
			vim.notify('nvim-jdtls.json: expected {"runtime": "<name>"}', vim.log.levels.WARN)
			return nil
		end

		return decoded.runtime
	end

	local wanted_runtime = read_project_runtime(root_dir)
	if wanted_runtime then
		local matched = false
		for _, rt in ipairs(runtimes) do
			local is_match = rt.name == wanted_runtime
			rt.default = is_match or nil
			if is_match then
				matched = true
			end
		end

		if matched then
			vim.notify("jdtls: project override -> " .. wanted_runtime, vim.log.levels.INFO)
		else
			vim.notify(
				"jdtls_conf.json: '" .. wanted_runtime .. "' isn't a configured runtime name, ignoring",
				vim.log.levels.WARN
			)
		end
	end
	--

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
		capabilities = require("blink.cmp").get_lsp_capabilities(),
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
end
