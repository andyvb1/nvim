return function()
	require("trouble").setup({
		auto_close = false, -- auto close when last file is closed
		auto_open = false, -- auto open when there are diagnostics
		auto_preview = true, -- automatically open preview when on an item
		auto_refresh = true, -- auto refresh when content changes
		auto_jump = false, -- auto jump to the item when there's only one
		focus = false, -- Focus the window when opened
		restore = true, -- restores the last used filter when opening
		follow = true, -- Follow the item under the cursor
		indent_guides = true, -- show indent guides
		max_items = 200, -- limit number of items that can be displayed
		multiline = true, -- render multi-line messages
		pinned = false, -- pin the buffer as the source for the opened trouble window
		warn_no_results = true, -- show a warning when there are no results
		open_no_results = false, -- open trouble even if there are no results
		win = {}, -- window options for the main trouble window
		modes = {
			-- symbols mode for LSP symbols
			symbols = {
				desc = "symbols",
				mode = "lsp_document_symbols",
				focus = false,
				win = { position = "right", width = 0.3 },
				filter = {
					-- remove anonymous functions
					["not"] = { ft = "lua", kind = "Function", name = "<anonymous>" },
					-- only show top level symbols
					-- any = { { kind = "Class" }, { kind = "Module" } },
				},
			},
		},
		-- severity levels to use
		icons = {
			indent = {
				top = "│ ",
				middle = "├─ ",
				last = "└─ ",
				fold_open = " ",
				fold_closed = " ",
				ws = "  ",
			},
			folder_closed = " ",
			folder_open = " ",
			kinds = {
				Array = " ",
				Boolean = "   ",
				Class = " ",
				Constant = "   ",
				Constructor = " ",
				Enum = " ",
				EnumMember = " ",
				Event = " ",
				Field = "   ",
				File = "   ",
				Function = "   ",
				Interface = " ",
				Key = " ",
				Method = "   ",
				Module = " ",
				Namespace = "   ",
				Null = " ",
				Number = "   ",
				Object = " ",
				Operator = " ",
				Package = " ",
				Property = "   ",
				String = " ",
				Struct = "   ",
				TypeParameter = " ",
				Variable = "   ",
			},
		},
		-- map of key to the action name
		keys = {
			["?"] = "help",
			r = "refresh",
			q = "close",
			["<esc>"] = "cancel",
			["<cr>"] = "jump",
			["j"] = "next",
			["k"] = "prev",
			["<c-s>"] = "jump_split",
			["<c-v>"] = "jump_vsplit",
			["p"] = "preview",
			["P"] = "toggle_preview",
			["o"] = "jump_close",
			["i"] = "inspect",
			["s"] = "switch_severity",
		},
	})
end
