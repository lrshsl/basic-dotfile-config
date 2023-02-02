vim.cmd([[

call plug#begin()
  " Themes
  Plug 'lifepillar/vim-colortemplate'
  Plug 'chriskempson/base16-vim'

  Plug 'lambdalisue/suda.vim'

  " Language Setup

  " Lsp
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  " Autocompletion
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'hrsh7th/cmp-nvim-lua'
  " Snippets
  Plug 'L3MON4D3/LuaSnip'
  Plug 'rafamadriz/friendly-snippets'

  Plug 'VonHeikemen/lsp-zero.nvim'


  " File Explorer (ctrl-o)
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'

  " Fuzzy finder
  Plug 'junegunn/fzf'

  " Syntax Highlighting & Linting
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " Plug 'dense-analysis/ale'

  " Formater
  Plug 'Chiel92/vim-autoformat'

  " Basic Editor Functionality
  Plug 'jiangmiao/auto-pairs'         " autoclose bracets & co
  "Plug 'tpope/vim-surround'

  " comment out / uncomment
  Plug 'tpope/vim-commentary'         

  " rgb color preview
  " Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
  
  " Further configuration might be required, read https://anoyaro84.github.io/blog/2020/nvim-setting/
  Plug 'sirver/UltiSnips'

call plug#end()
]])


-- Configuration for Plugins
require("nvimtree")
require("treesitter")

local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.set_preferences({
    set_lsp_keymaps = true,
    manage_nvim_cmp = true,
})
lsp.setup()
