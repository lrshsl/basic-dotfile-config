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
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-buffer',

			-- Snippets
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Telescope
			'nvim-telescope/telescope.nvim',
		},

		-- Configure Lsp Zero, Mason and Autocompletion directly after each other (order matters!)
		config = function()
			local lsp_zero = require 'lsp-zero'

			lsp_zero.extend_lspconfig {
				float_border = 'rounded',
				capabilities = require 'cmp_nvim_lsp'.default_capabilities(),
			}

			lsp_zero.on_attach(function(_, bufnr)
				lsp_zero.default_keymaps { buffer = bufnr, _ }

				require 'which-key'.add {
					mode = { 'n' },
					{ 'g',  group = 'goto' },
					{ 'gd', vim.lsp.buf.definition,              desc = 'Goto definition' },
					{ 'gD', vim.lsp.buf.declaration,             desc = 'Goto declaration' },
					{ 'gi', vim.lsp.buf.implementation,          desc = 'Goto implementation' },
					{ 'gr', vim.lsp.buf.definition,              desc = 'Goto references' },
					{ 'gh', '<cmd>ClangdSwitchSourceHeader<CR>', desc = 'Goto header/source' },
					-- Telescope handles other goto stuff
				}
				-- Navigate snippets
				-- vim.keymap.set({ 'i', 's' }, '<Tab>', function()
				-- 	if vim.snippet.active({ direction = 1 }) then
				-- 		vim.snippet.jump(1)
				-- 		return ''
				-- 	else
				-- 		return '<Tab>'
				-- 	end
				-- end, { expr = true })
			end)

			lsp_zero.format_on_save {
				format_opts = {
					async = false,
					timeout_ms = 1000,
				},
				servers = {
					['lua_ls'] = { 'lua' },
					['vimls'] = { 'vim' },
					['rust_analyzer'] = { 'rust' },
					['clangd'] = { 'c', 'cpp' },
					['pyright'] = { 'python' },
					['nimls'] = { 'nim' },
					['zls'] = { 'zig' },
					['vls'] = { 'vlang', 'v' },
					['gleam'] = { 'gleam' },
				}
			}

			-- Mason
			require 'mason'.setup {}
			require 'mason-lspconfig'.setup {
				ensure_installed = { 'lua_ls', 'vimls', 'rust_analyzer', 'clangd', 'pyright', 'nimls', 'zls', 'vls' },
				handlers = {
					function(server_name)
						require 'lspconfig'[server_name].setup {}
					end,
				}
			}
			require 'lspconfig'.gleam.setup {}

			-- Autocompletion
			local cmp = require 'cmp'
			local cmp_action = lsp_zero.cmp_action()

			cmp.setup {
				keyword_length = 3,
				sources = {
					{ name = 'codeium', keyword_length = 1, max_item_count = 3 },
					{ name = 'path' },
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'orgmode' },
					{ name = 'buffer',  keyword_length = 5 },
				},
				mapping = {
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-y>'] = cmp.mapping.confirm { select = true },
					['<C-c>'] = cmp.mapping.abort(),
					-- Backup for <C-e>
					['<C-k>'] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item { behavior = 'insert' }
						else
							cmp.complete()
						end
					end),
					['<C-e>'] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item { behavior = 'insert' }
						else
							cmp.complete()
						end
					end),
					['<C-n>'] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_next_item { behavior = 'insert' }
						else
							cmp.complete()
						end
					end),
				},
				formatting = lsp_zero.cmp_format { details = true },
				snippet = {
					expand = function(args)
						-- You need Neovim v0.10 to use vim.snippet
						vim.snippet.expand(args.body)
						-- require 'luasnip'.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			}

			-- `/` cmdline setup.
			-- cmp.setup.cmdline('/', {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	sources = {
			-- 		{ name = 'buffer' }
			-- 	}
			-- })

			-- `:` cmdline setup.
			-- cmp.setup.cmdline(':', {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	-- mapping = {
			-- 	-- 	['<C-e>'] = cmp.mapping(function()
			-- 	-- 		if cmp.visible() then
			-- 	-- 			cmp.select_prev_item { behavior = 'insert' }
			-- 	-- 		else
			-- 	-- 			cmp.complete()
			-- 	-- 		end
			-- 	-- 	end),
			-- 	-- 	['<C-n>'] = cmp.mapping(function()
			-- 	-- 		if cmp.visible() then
			-- 	-- 			cmp.select_next_item { behavior = 'insert' }
			-- 	-- 		else
			-- 	-- 			cmp.complete()
			-- 	-- 		end
			-- 	-- 	end),
			-- 	-- },
			-- 	sources = cmp.config.sources {
			-- 		{ name = 'path' },
			-- 		{ name = 'cmdline' }
			-- 	},
			-- 	matching = { disallow_symbol_nonprefix_matching = false }
			-- })
		end
	},

	{
		"folke/trouble.nvim",
		focus = true,
		opts = {
			modes = {
				lsp_errors = {
					mode = 'diagnostics',
					filter = {
						severity = vim.diagnostic.severity.ERROR
					}
				}
			},
		},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=true<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=true win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
