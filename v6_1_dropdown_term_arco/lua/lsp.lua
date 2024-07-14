return {

	-- Lsp Zero
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		lazy = false,
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'neovim/nvim-lspconfig',

			-- Autocompletion
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/nvim-cmp',

			-- Snippets
			'L3MON4D3/LuaSnip',

			-- Telescope
			'nvim-telescope/telescope.nvim',
		},

		-- Configure Lsp Zero, Mason and Autocompletion directly after each other (order matters!)
		config = function()
			local lsp_zero = require('lsp-zero')

			lsp_zero.on_attach(function(_, bufnr)
				-- see :help lsp-zero-keybindings
				lsp_zero.default_keymaps({ buffer = bufnr, _ })

				Nmap('gd', vim.lsp.buf.definition)
				Nmap('gD', vim.lsp.buf.declaration)
				Nmap('gi', vim.lsp.buf.implementation)
				Nmap('gr', vim.lsp.buf.references) -- Also <leader>fr -> Telescope
				-- Nmap('<leader>lf', vim.lsp.buf.format)
				-- Nmap('<leader>la', vim.lsp.buf.code_action)

				-- Telescope handles goto stuff in which-key-bindings
			end)
			lsp_zero.extend_lspconfig()

			-- Mason
			require('mason').setup({})
			require('mason-lspconfig').setup({
				handlers = {
					lsp_zero.default_setup,
				},
			})
            local lspconfig = require'lspconfig'
			lspconfig.wgsl_analyzer.setup {
				on_attach = lsp_zero.on_attach,
				cmd = { 'wgsl_analyzer' },
				filetypes = { 'wgsl' },
			}

			lspconfig.nim_langserver.setup{
				settings = {
					nim = {
						nimsuggestPath = "/usr/bin/nimsuggest"
					}
				}
			}
            lspconfig.gleam.setup({})

			-- Autocompletion
			local cmp = require('cmp')

			cmp.setup({
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'buffer' },
				},
				mapping = {
					['<C-y>'] = cmp.mapping.confirm({ select = true }),
					['<C-c>'] = cmp.mapping.abort(),
					['<C-e>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
					['<C-n>'] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_next_item({ behavior = 'insert' })
						else
							cmp.complete()
						end
					end),
				},
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
			})
		end
	},
}
