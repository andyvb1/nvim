return function()
	require("nvim-treesitter").setup({
		install_dir = vim.fn.stdpath("data") .. "/site",
	})

	-- replaces ensure_installed + auto_install
	require("nvim-treesitter").install({
		"java",
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

	vim.api.nvim_create_autocmd("FileType", {
		callback = function(args)
			local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype) or vim.bo[args.buf].filetype
			if pcall(vim.treesitter.language.add, lang) then
				pcall(vim.treesitter.start, args.buf, lang)
			end
		end,
	})
end
