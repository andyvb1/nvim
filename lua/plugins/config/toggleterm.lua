return function()
	require("toggleterm").setup({
		close_on_exit = false,
		autochdir = true,
		shell = vim.o.shell,
		size = 20,
	})
end
