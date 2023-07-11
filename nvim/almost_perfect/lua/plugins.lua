vim.cmd([[

call plug#begin()

    Plug 'nvim-lua/plenary.nvim'

    Plug 'ray-x/aurora'
    Plug 'sainnhe/sonokai'

    " File Explorer (<Space>o)
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'kyazdani42/nvim-web-devicons'


    " Syntax Highlighting
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


    " LSP "
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

" Autocompletion
"Plug 'hrsh7th/nvim-cmp'
"Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}

	" Formatting "
	Plug 'mhartington/formatter.nvim'

    " Basic Editor Functionality
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'

    Plug 'mg979/vim-visual-multi', {'branch': 'master'}     " multiple cursors

    Plug 'easymotion/vim-easymotion'
    Plug 'ThePrimeagen/harpoon'

    " Telescope
    Plug 'nvim-telescope/telescope.nvim'

    " Plug 'terryma/vim-multiple-cursors' " multiple cursors (ctrl-n)
    "Plug 'tpope/vim-surround'

    Plug 'junegunn/fzf'

    " Zen Mode
    Plug 'junegunn/limelight.vim'
    Plug 'junegunn/goyo.vim'

    " XTabline
    "Plug 'mg979/vim-xtabline'

    Plug 'Exafunction/codeium.vim'
    Plug 'liuchengxu/vista.vim'

call plug#end()
]])


-- Configuration for Plugins
require("nvimtree")
require("treesitter")
require("multi_cursors")
require("limelight_goyo")
require("harpoon_conf")
require("formatter_conf")
require("lsp")
