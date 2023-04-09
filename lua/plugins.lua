

require('packer').startup(function(use)

	use 'wbthomason/packer.nvim'

	use 'folke/tokyonight.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use 'theprimeagen/harpoon'

    -- Lsp
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'L3MON4D3/LuaSnip'

    use 'VonHeikemen/lsp-zero.nvim'

    use 'tpope/vim-commentary'

end)


require('plugins_setup')


-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<space>;f', builtin.find_files, {})
vim.keymap.set('n', '<space>;g', builtin.live_grep, {})
vim.keymap.set('n', '<space>b', builtin.buffers, {})



-- Lsp Zero
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()


