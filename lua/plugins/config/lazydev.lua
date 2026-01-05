return function()
	local luvit_meta_library = vim.fn.stdpath("data") .. "/lazy/luvit-meta/library"

	require("lazydev").setup({
		library = {
			{ path = luvit_meta_library, words = { "vim%.uv" } },
		},
	})
end
