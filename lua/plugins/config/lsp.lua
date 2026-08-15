return function()
	local lsp = vim.lsp

	pcall(function()
		lsp.enable("nushell")
	end)

	vim.diagnostic.config({
		update_in_insert = false,
	})

	require("lspmappings")
end
