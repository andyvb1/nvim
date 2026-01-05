return function()
	local lsp = vim.lsp

	pcall(function()
		lsp.enable("nushell")
	end)

	require("lspmappings")
end
