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
	{ 'nvim-lua/plenary.nvim',       lazy = true },
	{ 'echasnovski/mini.icons',      lazy = true },
	{ 'nvim-tree/nvim-web-devicons', lazy = true },

	--> Platformio
	{ 'normen/vim-pio',              lazy = true },

	--> Colorscheme
	{ 'sainnhe/sonokai',             lazy = true },

	--> Essentials for editing
	require 'treesitter_conf',
	'tpope/vim-surround',
	'tpope/vim-repeat',
	'tpope/vim-commentary',

	require 'autopairs_conf',

	--> Undotree
	{ 'mbbill/undotree',        lazy = true },

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
	-- require 'harpoon',

	--> Fuzzy finders
	require 'telescope_conf',

	--> Noice
	require 'noice_conf',

	--> Integrate wezterm
	require 'navigator',

	--> Zen mode
	{ 'junegunn/goyo.vim',      lazy = true },
	{ 'junegunn/limelight.vim', lazy = true },
}

require 'lazy'.setup(plugins, {})
