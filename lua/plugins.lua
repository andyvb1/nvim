local config_dir = "plugins.config."

local plugins = {
	--- Themes
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		priority = 1000,
		config = require(config_dir .. "kanagawa"),
	},
	{
		"sainnhe/everforest",
		config = require(config_dir .. "everforest"),
	},
	{
		"savq/melange-nvim",
		config = require(config_dir .. "melange"),
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		opts = {},
		config = require(config_dir .. "tokyonight"),
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = require(config_dir .. "catppuccin"),
	},
	{
		"eldritch-theme/eldritch.nvim",
		lazy = true,
		priority = 1000,
		config = require(config_dir .. "eldritch"),
	},
	---
	{
		"akinsho/toggleterm.nvim",
		config = require(config_dir .. "toggleterm"),
	},
	{
		"3rd/image.nvim",
		config = require(config_dir .. "image"),
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		config = require(config_dir .. "ufo"),
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		tag = "v2.20.8",
		config = require(config_dir .. "indent_blankline"),
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = require(config_dir .. "treesitter"),
		branch = "main",
		build = ":TSUpdate",
	},
	{
		"Wansmer/treesj",
		config = require(config_dir .. "treesj"),
	},
	{
		"numToStr/Comment.nvim",
		config = require(config_dir .. "comment"),
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = require(config_dir .. "telescope"),
	},
	{
		"folke/trouble.nvim",
		config = require(config_dir .. "trouble"),
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = require(config_dir .. "lualine"),
	},
	{
		"ThePrimeagen/harpoon",
		config = require(config_dir .. "harpoon"),
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	},
	{
		"folke/which-key.nvim",
		tag = "v1.5.1",
		config = require(config_dir .. "which_key"),
	},
	{
		"folke/flash.nvim",
		config = require(config_dir .. "flash"),
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = require(config_dir .. "blink"),
	},
	{ "tpope/vim-surround" },
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = require(config_dir .. "mason"),
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = require(config_dir .. "mason_lspconfig"),
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = require(config_dir .. "lsp"),
	},
	{
		"folke/lazydev.nvim",
		lazy = false,
		dependencies = {
			{ "Bilal2453/luvit-meta", lazy = true },
		},
		config = require(config_dir .. "lazydev"),
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"nvim-treesitter/nvim-treesitter",
		},
		config = require(config_dir .. "noice"),
	},
	{
		"nvim-pack/nvim-spectre",
		config = require(config_dir .. "spectre"),
	},
	{ "mbbill/undotree" },
	{
		"lewis6991/gitsigns.nvim",
		config = require(config_dir .. "gitsigns"),
	},
	{
		"nvimdev/lspsaga.nvim",
		config = require(config_dir .. "lspsaga"),
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
		config = require(config_dir .. "neo_tree"),
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-mini/mini.icons" },
		config = require(config_dir .. "alphaconfig"),
	},
	{
		"mfussenegger/nvim-jdtls",
		dependencies = { "mfussenegger/nvim-dap" },
		config = require(config_dir .. "jdtls"),
	},
	{
		"JavaHello/spring-boot.nvim",
		ft = { "java", "yaml", "jproperties" },
		dependencies = {
			"mfussenegger/nvim-jdtls",
		},
		---@type bootls.Config
		opts = {},
	},
	{
		"mfussenegger/nvim-dap",
		config = require(config_dir .. "dap_setup"),
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = require(config_dir .. "dapui"),
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = require(config_dir .. "colorizer"),
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
		config = require(config_dir .. "conform"),
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = require(config_dir .. "todo-comments"),
	},
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
		priority = 1000,
		opts = require(config_dir .. "solarized_osaka"),
	},
	{
		"ribru17/bamboo.nvim",
		lazy = true,
		priority = 1000,
		config = require(config_dir .. "bamboo"),
	},
	{
		"ThePrimeagen/vim-be-good",
	},
	{
		"RedsXDD/neopywal.nvim",
		name = "neopywal",
		lazy = true,
		priority = 1000,
		opts = {},
		config = require(config_dir .. "neopywal"),
	},
	-- local
	--{ dir = "" },
}

return plugins
