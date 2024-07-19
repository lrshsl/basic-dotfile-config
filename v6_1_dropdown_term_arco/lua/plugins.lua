-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)


-- Actual plugins
local plugins = {
	--> Base dependencies
	'nvim-lua/plenary.nvim',
	'echasnovski/mini.icons',
	'nvim-tree/nvim-web-devicons',

	--> Platformio
	'normen/vim-pio',

	--> Colorscheme
	{
		'sainnhe/sonokai',
		lazy = true
	},

	--> Essentials for editing
	'nvim-treesitter/nvim-treesitter',
	'tpope/vim-surround',
	'tpope/vim-repeat',
	'tpope/vim-commentary',
	{
		'm4xshen/autoclose.nvim',
		config = function() require('autoclose').setup() end
	},

	--> Undotree
	'mbbill/undotree',

	--> Sneak around in a file with s/S
	'justinmk/vim-sneak',

	--> LSP
	require 'lsp',

	--> Latex
	require 'latex',

	--> AI helper
	'exafunction/codeium.vim',

	--> Space(macs|vim)-like keybinding preview
	require 'which_key',

	--> Session manager
	require 'session_manager_conf',

	--> Files
	require 'neotree',
	require 'harpoon',

	--> Fuzzy finders
	require 'telescope_conf',

	--> Integrate wezterm
	require 'navigator',

	--> Zen mode
	'junegunn/goyo.vim',
	'junegunn/limelight.vim',
}
local opts = {}

require'lazy'.setup(plugins, opts)
