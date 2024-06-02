-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)


-- Actual plugins
local plugins = {
	'nvim-lua/plenary.nvim',

	-- Colorscheme
	{
		"sainnhe/sonokai",
		lazy = true
	},

	-- Essentials for editing
	'nvim-treesitter/nvim-treesitter',
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"tpope/vim-commentary",
	{
		"m4xshen/autoclose.nvim",
		config = function() require("autoclose").setup() end
	},

	-- LSP
	require "lsp",

	-- AI helper
	"exafunction/codeium.vim",

	-- Latex
	require("latex"),

	-- Space(macs|vim)-like keybinding preview
	require 'which_key',

	-- Sneak'n'run around in a file
	"justinmk/vim-sneak",

    -- Session manager
    require 'session_manager_conf',

	-- Fuzzy finders
	require "telescope_conf",

	-- Filetree
	require "neotree",

    -- Integrate wezterm
	require "navigator",

    -- Zen mode
	"junegunn/goyo.vim",
	"junegunn/limelight.vim",
}
local opts = {}

require("lazy").setup(plugins, opts)

