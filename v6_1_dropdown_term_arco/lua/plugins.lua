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

	{ 'ollykel/v-vim',               ft = 'v' },

	--> Platformio
	{ 'normen/vim-pio',              cmd = "PIO" },

	--> Colorscheme
	{ 'sainnhe/sonokai',             lazy = true },

	--> Text editing
	require 'treesitter_conf',
	'tpope/vim-surround',
	'tpope/vim-repeat',
	'tpope/vim-commentary',
	{ "smjonas/inc-rename.nvim", opts = { show_message = false, } },

	require 'autopairs_conf',

	{
		'nvim-orgmode/orgmode',
		event = 'VeryLazy',
		ft = { 'org' },
		config = function()
			-- Setup orgmode
			require('orgmode').setup({
				org_agenda_files = '~/orgfiles/**/*',
				org_default_notes_file = '~/orgfiles/refile.org',
			})

			-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
			-- add ~org~ to ignore_install
		end,
	},

	--> Undotree
	{ 'mbbill/undotree',         lazy = false },

	--> Sneak around in a file with s/S
	'justinmk/vim-sneak',

	--> LSP
	require 'lsp',

	--> Latex
	require 'latex',

	--> AI helper
	{ 'exafunction/codeium.nvim', opts = {} },

	--> Space(macs|vim)-like keybinding preview
	require 'which_key',

	--> Session manager
	require 'session_manager_conf',

	--> Files
	require 'neotree',
	require 'harpoon',
	{ 'stevearc/oil.nvim',        opts = {}, cmd = 'Oil' },

	--> Fuzzy finders
	require 'telescope_conf',

	--> Integrate wezterm
	require 'navigator',

	--> Zen mode
	{ 'junegunn/goyo.vim',      cmd = 'Goyo' },
	{ 'junegunn/limelight.vim', cmd = 'Limelight' },
}

require 'lazy'.setup(plugins, {})
