return function()
	local alpha = require("alpha")

	-- choose theme here
	local theme = require("plugins.config.alphathemes.cowsay")

	alpha.setup(theme.config)

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "alpha",
		callback = function()
			vim.opt_local.foldenable = false
		end,
	})
end
