require('mason.settings').set({
	ui = {
		border = 'rounded'
	}
})

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	'lua_ls', 'marksman',
	'rust_analyzer',
	'pyright', 'clangd', -- Note: pyright requires npm
	-- 'hls',
	-- 'texlab'
})

lsp.setup_servers({
	'rust_analyzer',
	'lua_ls', 'marksman',
	'pyright', 'clangd',
	'java_language_server',
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()


-- lsp.setup_nvim_cmp({
	-- mapping = cmp_mappings
-- })

lsp.on_attach(function(client, bufnr)

	local opts = { buffer = bufnr, remap = true }
	lsp.buffer_autoformat()
	lsp.default_keymaps({
		buffer = bufnr,
		omit = {
			'K'
		}
	})

	local builtin = require("telescope.builtin")

	-- Find related
	vim.keymap.set("n", 'gd', builtin.lsp_definitions, opts)
	vim.keymap.set("n", 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", 'gi', builtin.lsp_implementations, opts)
	vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
	vim.keymap.set("n", "<space>ls", vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set("n", 'go', builtin.lsp_type_definitions, opts)

	-- (Signature) help
	vim.keymap.set("n", "<space>lh", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("i", '<C-k>', vim.lsp.buf.signature_help, opts)

	-- Diagnostics
	--vim.keymap.set("n", "<space>ld", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", '[d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", ']d', vim.diagnostic.goto_next, opts)

	-- Code actions
	vim.keymap.set("n", "<space>lca",vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<space>lr", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", '<space>la', "<cmd>CodeActionMenu<cr>", opts)

	vim.keymap.set("n", '<space>F', "<cmd>LspZeroFormat<CR>:w<CR>", opts)
end)

-- local cmp = require 'cmp'

-- local cmp_mappings = {
-- 	["<C-b>"] = cmp.mapping.scroll_docs(-4),
-- 	["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 	['<C-l>'] = cmp.mapping.complete(),
-- 	["<C-e>"] = cmp.mapping.abort(),
-- 	["<CR>"] = cmp.mapping.confirm({ select = true }),
-- };

-- cmp.setup({
-- 	sources = {
-- 		{ name = 'nvim_lsp', keyword_length = 3 },
-- 		{ name = 'luasnip',  keyword_length = 1 },
-- 		{ name = 'buffer',   keyword_length = 3 }, -- Low number for CONSTANTS
-- 	},
-- 	mapping = cmp_mappings,
-- })


lsp.setup()
