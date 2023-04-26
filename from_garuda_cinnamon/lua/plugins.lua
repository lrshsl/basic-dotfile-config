

require('packer').startup(function(use)

	use 'wbthomason/packer.nvim'

	use 'folke/tokyonight.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-tree/nvim-web-devicons'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use 'theprimeagen/harpoon'

    -- Lsp
    use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  requires = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},      
    {                                
      'williamboman/mason.nvim',
      run = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'},

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},   
  }
}

    use 'tpope/vim-commentary'

    -- Formatter
    use{'jose-elias-alvarez/null-ls.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
    }

    use 'jay-babu/mason-null-ls.nvim'

    use('MunifTanjim/prettier.nvim')

end)


require('plugins_setup')


