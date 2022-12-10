vim.cmd([[

call plug#begin()

    " File Explorer (ctrl-o)
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'kyazdani42/nvim-web-devicons'

    " Syntax Highlighting
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Linting
    " Plug 'dense-analysis/ale'

    " Autocompletion
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'


    " Basic Editor Functionality
    Plug 'jiangmiao/auto-pairs'         " autoclose bracets & co

    Plug 'tpope/vim-commentary'         " comment out / uncomment

    " Plug 'terryma/vim-multiple-cursors' " multiple cursors (ctrl-n)
    "Plug 'tpope/vim-surround'

    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
    Plug 'junegunn/fzf'

call plug#end()
]])


-- Configuration for Plugins
require("nvimtree")
require("treesitter")
require("completionnvim")
