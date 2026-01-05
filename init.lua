-- Setting up leader key
vim.g.mapleader = " "

-- Apply general vim settings
require("settings")
-- Initialize Lazy Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable
		lazypath,
	})
end

-- Prepend lazypath to the runtimepath
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
-- Colorscheme
require("colorscheme")
-- Key mappings
require("keymappings")
