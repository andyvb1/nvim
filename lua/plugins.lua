local plugins = {
	--- Themes
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = require("plugins.config.kanagawa"),
	},
	{
		"sainnhe/everforest",
		config = require("plugins.config.everforest"),
	},
	{
		"savq/melange-nvim",
		config = require("plugins.config.melange"),
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = require("plugins.config.tokyonight"),
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = require("plugins.config.catppuccin"),
	},
	{
		"eldritch-theme/eldritch.nvim",
		lazy = false,
		priority = 1000,
		config = require("plugins.config.eldritch"),
	},
	---
	{
		"akinsho/toggleterm.nvim",
		config = require("plugins.config.toggleterm"),
	},
	{
		"3rd/image.nvim",
		config = require("plugins.config.image"),
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		config = require("plugins.config.ufo"),
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		tag = "v2.20.8",
		config = require("plugins.config.indent_blankline"),
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = require("plugins.config.treesitter"),
	},
	{
		"Wansmer/treesj",
		config = require("plugins.config.treesj"),
	},
	{
		"numToStr/Comment.nvim",
		config = require("plugins.config.comment"),
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = require("plugins.config.telescope"),
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = require("plugins.config.lualine"),
	},
	{
		"ThePrimeagen/harpoon",
		config = require("plugins.config.harpoon"),
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	},
	{
		"folke/which-key.nvim",
		tag = "v1.5.1",
		config = require("plugins.config.which_key"),
	},
	{
		"folke/flash.nvim",
		config = require("plugins.config.flash"),
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"rafamadriz/friendly-snippets",
		},
		config = require("plugins.config.cmp"),
	},
	{ "tpope/vim-surround" },
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = require("plugins.config.mason"),
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = require("plugins.config.mason_lspconfig"),
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = require("plugins.config.lsp"),
	},
	{
		"folke/lazydev.nvim",
		lazy = false,
		dependencies = {
			{ "Bilal2453/luvit-meta", lazy = true },
		},
		config = require("plugins.config.lazydev"),
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"nvim-treesitter/nvim-treesitter",
		},
		config = require("plugins.config.noice"),
	},
	{
		"nvim-pack/nvim-spectre",
		config = require("plugins.config.spectre"),
	},
	{ "mbbill/undotree" },
	{
		"lewis6991/gitsigns.nvim",
		config = require("plugins.config.gitsigns"),
	},
	{
		"nvimdev/lspsaga.nvim",
		config = require("plugins.config.lspsaga"),
	},

	{ "kyazdani42/nvim-web-devicons" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = false,
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
		config = require("plugins.config.neo_tree"),
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-mini/mini.icons" },
		config = require("plugins.config.alphaconfig"),
	},
	{
		"mfussenegger/nvim-jdtls",
		dependencies = { "mfussenegger/nvim-dap" },
		config = require("plugins.config.jdtls"),
	},
	{
		"mfussenegger/nvim-dap",
		config = require("plugins.config.dap_setup"),
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = require("plugins.config.dapui"),
	},
	{ "robitx/gp.nvim" },
	{
		"norcalli/nvim-colorizer.lua",
		config = require("plugins.config.colorizer"),
	},
	{
		"benomahony/uv.nvim",
		opts = {
			picker_integration = true,
		},
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"stevearc/conform.nvim",
		config = require("plugins.config.conform"),
	},
	-- local
	--{ dir = "" },
}

return plugins
