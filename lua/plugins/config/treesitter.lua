return function()
	require("nvim-treesitter").setup({
		install_dir = vim.fn.stdpath("data") .. "/site", -- default, explicit for clarity
	})

	-- replaces ensure_installed + auto_install
	-- (async by default; chain :wait(300000) if you want it synchronous on startup)
	require("nvim-treesitter").install({
		"bash",
		"c",
		"fish",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"markdown",
		"markdown_inline",
		"rust",
	})

	-- replaces highlight.enable = true
	-- attaches to ANY filetype with an available parser, no hardcoded list needed
	vim.api.nvim_create_autocmd("FileType", {
		callback = function(args)
			local buf, ft = args.buf, args.match

			-- replaces your file-size `disable` function
			local max_filesize = 100 * 1024
			local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return
			end

			local lang = vim.treesitter.language.get_lang(ft)
			if not lang then
				return
			end
			if vim.treesitter.language.add(lang) then
				vim.treesitter.start(buf, lang)
			end
		end,
	})
end
