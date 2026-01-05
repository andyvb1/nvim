local utils = require("utils")
local wk = require("which-key")
local builtin = require("telescope.builtin")
local dap = require("dap")
local jdtls = require("jdtls")
local dapui_controls = require("dapui.config").controls or {}
local dapui_icons = dapui_controls.icons or {}

local function with_icon(icon, label)
	if icon then
		return icon .. " " .. label
	end
	return label
end

--  ToggleTerm Key Mappings
utils.map("i", [[<C-\>]], '<cmd>exe v:count1 . "ToggleTerm size=80 direction=vertical"<CR>')
utils.map("n", [[<C-\>]], '<cmd>exe v:count1 . "ToggleTerm size=20 direction=horizontal"<CR>')

-- Terminal keymaps (buffer-local)
function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

--  Paste without overwriting clipboard
vim.keymap.set("x", "p", '"_dP"', { noremap = true, silent = true })

--  BufferLine
utils.map("n", "gb", ":BufferLinePick<CR>")
utils.map("n", "<leader>bl", ":BufferLinePick<CR>")

--  Neo-tree
vim.keymap.set("n", "<F2>", "<Cmd>Neotree toggle<CR>")
-- utils.map('n', '<C-n>', ':Neotree toggle<CR>') -- optional

--code actions
wk.register({
	d = {
		name = "Debug",
		b = { dap.toggle_breakpoint, "Toggle Breakpoint" },
		B = {
			function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			"Conditional Breakpoint",
		},
		c = { dap.continue, with_icon(dapui_icons.play, "Continue / Attach") },
		C = {
			function()
				jdtls.test_class()
			end,
			"Java Test Class",
		},
		s = { dap.step_over, with_icon(dapui_icons.step_over, "Step Over") },
		i = { dap.step_into, with_icon(dapui_icons.step_into, "Step Into") },
		o = { dap.step_out, with_icon(dapui_icons.step_out, "Step Out") },
		r = { dap.repl.open, "Open REPL" },
		l = { dap.run_last, with_icon(dapui_icons.run_last, "Run Last") },
		t = { dap.terminate, with_icon(dapui_icons.terminate, "Terminate") },
		m = {
			function()
				_G.dap_enable_step_mode()
			end,
			"Stepping Mode",
		},
	},
}, { prefix = "<leader>", mode = "n" })
--  UFO Folding
vim.keymap.set("n", "zN", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

--  Telescope
utils.map("n", "<leader>ff", ":Telescope find_files<CR>") -- Optional
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

--  Harpoon
vim.keymap.set("n", "<leader>hn", require("harpoon.ui").nav_next)
vim.keymap.set("n", "<leader>hp", require("harpoon.ui").nav_prev)
utils.map("n", "<leader>hm", ":Telescope harpoon marks<CR>")

wk.register({
	h = {
		name = "harpoon",
		x = {
			function()
				require("harpoon.mark").add_file()
			end,
			"Mark file",
		},
	},
}, { prefix = "<leader>" })

--  Spectre
vim.keymap.set("n", "<leader>S", function()
	require("spectre").toggle()
end, { desc = "Toggle Spectre" })
vim.keymap.set("n", "<leader>sw", function()
	require("spectre").open_visual({ select_word = true })
end, { desc = "Search current word" })
vim.keymap.set(
	"v",
	"<leader>sw",
	'<esc><cmd>lua require("spectre").open_visual()<CR>',
	{ desc = "Search current word" }
)
vim.keymap.set("n", "<leader>sf", function()
	require("spectre").open_file_search({ select_word = true })
end, { desc = "Search on current file" })

--  Flash
wk.register({
	l = {
		name = "flash",
		s = {
			function()
				require("flash").jump()
			end,
			"Flash Jump",
		},
		t = {
			function()
				require("flash").treesitter()
			end,
			"Flash Treesitter",
		},
		r = {
			function()
				require("flash").treesitter_search()
			end,
			"Flash Treesitter Search",
		},
	},
}, { prefix = "<leader>" })

--  ChatGPT (Gp)
wk.register({
	u = {
		name = "Chat GPT",
		g = { "<cmd>GpChatToggle popup<cr>", "Toggle Chat" },
		r = { "<cmd>GpChatRespond<cr>", "Respond" },
		n = { "<cmd>GpChatNew popup<cr>", "New Chat" },
	},
}, { mode = "n", prefix = "<leader>" })

--  Gitsigns
wk.register({
	g = {
		name = "Gitsigns",
		s = { "<cmd>lua require('gitsigns').stage_hunk()<cr>", "Stage Hunk" },
		u = { "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", "Undo Stage Hunk" },
		r = { "<cmd>lua require('gitsigns').reset_hunk()<cr>", "Reset Hunk" },
		p = { "<cmd>lua require('gitsigns').preview_hunk()<cr>", "Preview Hunk" },
		b = { "<cmd>lua require('gitsigns').blame_line()<cr>", "Blame Line" },
		f = { "<cmd>lua require('gitsigns').diffthis('~1')<cr>", "Diff This" },
		n = { "<cmd>lua require('gitsigns').next_hunk()<cr>", "Next Hunk" },
	},
}, { prefix = "<leader>" })

--  Lspsaga
wk.register({
	l = {
		name = "Lspsaga",
		c = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
		o = { "<cmd>Lspsaga outline<cr>", "Outline" },
		r = { "<cmd>Lspsaga rename<cr>", "Rename" },
		d = { "<cmd>Lspsaga goto_definition<cr>", "Lsp GoTo Definition" },
		f = { "<cmd>Lspsaga finder<cr>", "Lsp Finder" },
		p = { "<cmd>Lspsaga preview_definition<cr>", "Preview Definition" },
		s = { "<cmd>Lspsaga signature_help<cr>", "Signature Help" },
		w = { "<cmd>Lspsaga show_workspace_diagnostics<cr>", "Show Workspace Diagnostics" },
	},
}, { prefix = "<leader>" })

vim.keymap.set("n", "<leader>C", function()
	local schemes = vim.fn.getcompletion("", "color")

	vim.ui.select(schemes, {
		prompt = "Select colorscheme",
	}, function(choice)
		if choice then
			vim.cmd.colorscheme(choice)
		end
	end)
end, { desc = "Select colorscheme" })
