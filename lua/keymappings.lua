local wk = require("which-key")
local builtin = require("telescope.builtin")
local dap = require("dap")
local jdtls = require("jdtls")
local dapui_controls = require("dapui.config").controls or {}
local ufo = require("plugins.config.ufo")
local dapui_icons = dapui_controls.icons or {}

-- Terminal keymaps
function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Paste without overwriting clipboard
vim.keymap.set("x", "p", "P")
vim.keymap.set("x", "P", "p")

-- General / plugins without a leader prefix
wk.add({
	{ "<F2>", "<Cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
	{ "gb", ":BufferLinePick<CR>", desc = "Pick buffer (BufferLine)" },
	{
		[[<C-\>]],
		'<cmd>exe v:count1 . "ToggleTerm size=20 direction=horizontal"<CR>',
		desc = "Toggle terminal (horizontal)",
	},
	{
		[[<C-\>]],
		'<cmd>exe v:count1 . "ToggleTerm size=80 direction=vertical"<CR>',
		desc = "Toggle terminal (vertical)",
		mode = "i",
	},
})

-- Leader: misc
wk.add({
	{ "<leader>q", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics List (Trouble)" },
	{
		"<leader>C",
		function()
			local schemes = vim.fn.getcompletion("", "color")
			vim.ui.select(schemes, { prompt = "Select colorscheme" }, function(choice)
				if choice then
					vim.cmd.colorscheme(choice)
				end
			end)
		end,
		desc = "Select colorscheme",
	},
})

-- Folding (UFO)
wk.add({
	{ "zR", require("ufo").openAllFolds, desc = "Open All Folds" },
	{ "zM", require("ufo").closeAllFolds, desc = "Close All Folds" },
	{ "zr", require("ufo").openFoldsExceptKinds, desc = "Fold Less" },
	{ "zm", require("ufo").closeFoldsWith, desc = "Fold More" },
})

-- Debug
wk.add({
	{ "<leader>d", group = "Debug" },
	{
		"<leader>d1",
		function()
			jdtls.test_class()
		end,
		desc = "Test java class",
	},
	{ "<leader>db", dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
	{
		"<leader>dB",
		function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end,
		desc = "Conditional Breakpoint",
	},
	{ "<leader>dc", dap.continue, desc = "Continue / Attach", icon = dapui_icons.play },
	{
		"<leader>dC",
		function()
			jdtls.test_nearest_method()
		end,
		desc = "jdt test nearest method",
	},
	{ "<leader>ds", dap.step_over, desc = "Step Over", icon = dapui_icons.step_over },
	{ "<leader>di", dap.step_into, desc = "Step Into", icon = dapui_icons.step_into },
	{ "<leader>do", dap.step_out, desc = "Step Out", icon = dapui_icons.step_out },
	{ "<leader>dr", dap.repl.open, desc = "Open REPL" },
	{ "<leader>dl", dap.run_last, desc = "Run Last", icon = dapui_icons.run_last },
	{ "<leader>dt", dap.terminate, desc = "Terminate", icon = dapui_icons.terminate },
	{
		"<leader>dm",
		function()
			_G.dap_enable_step_mode()
		end,
		desc = "Stepping Mode",
	},
})

-- Telescope
wk.add({
	{ "<leader>f", group = "Find" },
	{ "<leader>ff", builtin.find_files, desc = "files" },
	{ "<leader>fg", builtin.live_grep, desc = "live grep" },
	{ "<leader>fs", builtin.lsp_dynamic_workspace_symbols, desc = "workspace symbols" },
	{ "<leader>fb", builtin.buffers, desc = "buffers" },
	{ "<leader>fh", builtin.help_tags, desc = "help tags" },
})

-- Harpoon
wk.add({
	{ "<leader>h", group = "harpoon" },
	{ "<leader>hn", require("harpoon.ui").nav_next, desc = "Next mark" },
	{ "<leader>hp", require("harpoon.ui").nav_prev, desc = "Previous mark" },
	{ "<leader>hm", ":Telescope harpoon marks<CR>", desc = "Marks (Telescope)" },
	{
		"<leader>hx",
		function()
			require("harpoon.mark").add_file()
		end,
		desc = "Mark file",
	},
})

-- Spectre
wk.add({
	{
		"<leader>S",
		function()
			require("spectre").toggle()
		end,
		desc = "Toggle Spectre",
	},
	{ "<leader>s", group = "spectre" },
	{
		"<leader>sw",
		function()
			require("spectre").open_visual({ select_word = true })
		end,
		desc = "Search current word",
	},
	{
		"<leader>sw",
		'<esc><cmd>lua require("spectre").open_visual()<CR>',
		desc = "Search current word",
		mode = "v",
	},
	{
		"<leader>sf",
		function()
			require("spectre").open_file_search({ select_word = true })
		end,
		desc = "Search on current file",
	},
})

-- Flash
wk.add({
	{
		"<leader>lt",
		function()
			require("flash").treesitter()
		end,
		desc = "Flash Treesitter",
	},
	-- { "<leader>ls", function() require("flash").jump() end, desc = "Flash Jump" },
	-- { "<leader>lr", function() require("flash").treesitter_search() end, desc = "Flash Treesitter Search" },
})

-- Gitsigns
wk.add({
	{ "<leader>G", group = "Gitsigns" },
	{ "<leader>Gs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", desc = "Stage Hunk" },
	{ "<leader>Gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },
	{ "<leader>Gr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", desc = "Reset Hunk" },
	{ "<leader>Gp", "<cmd>lua require('gitsigns').preview_hunk()<cr>", desc = "Preview Hunk" },
	{ "<leader>Gb", "<cmd>lua require('gitsigns').blame_line()<cr>", desc = "Blame Line" },
	{ "<leader>Gf", "<cmd>lua require('gitsigns').diffthis('~1')<cr>", desc = "Diff This" },
	{ "<leader>Gn", "<cmd>lua require('gitsigns').next_hunk()<cr>", desc = "Next Hunk" },
})

-- Lspsaga
wk.add({
	{ "<leader>l", group = "Lspsaga" },
	{ "<leader>lc", "<cmd>Lspsaga code_action<cr>", desc = "Code Action" },
	{ "<leader>lo", "<cmd>Lspsaga outline<cr>", desc = "Outline" },
	{ "<leader>lr", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
	{ "<leader>ld", "<cmd>Lspsaga goto_definition<cr>", desc = "Lsp GoTo Definition" },
	{ "<leader>lf", "<cmd>Lspsaga finder<cr>", desc = "Lsp Finder" },
	{ "<leader>lp", "<cmd>Lspsaga preview_definition<cr>", desc = "Preview Definition" },
	{ "<leader>ls", "<cmd>Lspsaga signature_help<cr>", desc = "Signature Help" },
	{ "<leader>lw", "<cmd>Lspsaga show_workspace_diagnostics<cr>", desc = "Show Workspace Diagnostics" },
})
