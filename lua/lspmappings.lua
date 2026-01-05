-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Diagnostics: float" })
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Diagnostics: goto_prev" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Diagnostics: goto_next" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Diagnostics: list Diagnostics" })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("keep", { desc = "LSP: Declaration" }, opts))
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("keep", { desc = "LSP: Definition" }, opts))
		vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("keep", { desc = "LSP: Hover" }, opts))
		vim.keymap.set(
			"n",
			"gi",
			vim.lsp.buf.implementation,
			vim.tbl_extend("keep", { desc = "LSP: Implementation" }, opts)
		)
		vim.keymap.set(
			"n",
			"<C-k>",
			vim.lsp.buf.signature_help,
			vim.tbl_extend("keep", { desc = "LSP: Signature Help" }, opts)
		)
		vim.keymap.set(
			"i",
			"<C-k>",
			vim.lsp.buf.signature_help,
			vim.tbl_extend("keep", { desc = "LSP: Signature Help" }, opts)
		)
		vim.keymap.set(
			"n",
			"<space>wa",
			vim.lsp.buf.add_workspace_folder,
			vim.tbl_extend("keep", { desc = "LSP: Add Workspace Folder" }, opts)
		)
		vim.keymap.set(
			"n",
			"<space>wr",
			vim.lsp.buf.remove_workspace_folder,
			vim.tbl_extend("keep", { desc = "LSP: Remove Workspace Folder" }, opts)
		)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, vim.tbl_extend("keep", { desc = "LSP: List Workspace Folders" }, opts))
		vim.keymap.set(
			"n",
			"<space>D",
			vim.lsp.buf.type_definition,
			vim.tbl_extend("keep", { desc = "LSP: Type Definition" }, opts)
		)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, vim.tbl_extend("keep", { desc = "LSP: Rename" }, opts))
		vim.keymap.set(
			{ "n", "v" },
			"<space>ca",
			vim.lsp.buf.code_action,
			vim.tbl_extend("keep", { desc = "LSP: Code Action" }, opts)
		)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("keep", { desc = "LSP: References" }, opts))
		-- conform better?
		--[[vim.keymap.set("n", "<F3>", function()
            vim.lsp.buf.format({ async = true })
        end, vim.tbl_extend("keep", { desc = "LSP: Format" }, opts))]]
		vim.keymap.set({ "n", "v" }, "<F3>", function()
			require("conform").format({
				lsp_fallback = true,
				async = true,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or selection" })
	end,
})
