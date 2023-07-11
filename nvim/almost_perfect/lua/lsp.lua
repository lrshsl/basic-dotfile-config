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

lsp.setup_servers({ 'rust_analyzer' })

-- Fix Undefined global 'vim'
lsp.nvim_workspace()


-- lsp.setup_nvim_cmp({
-- 	mapping = cmp_mappings
-- })


lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = 'E',
		warn = 'W',
		hint = 'H',
		info = 'I'
	}
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = true }
	lsp.buffer_autoformat()
	lsp.default_keymaps({
		buffer = bufnr,
		omit = {
			'<Tab>', 'K'
		}
	})

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
	vim.keymap.set("n", "<space>k", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<space>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<space>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "<space>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set('n', '<space>vr', '<cmd>Telescope lsp_references<cr>', { buffer = true })
	vim.keymap.set("n", "<space>rn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-s>", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
end)


-- local cmp = require 'cmp'

-- local cmp_mappings = {
-- 	["<C-b>"] = cmp.mapping.scroll_docs(-4),
-- 	["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 	['<C-Space>'] = cmp.mapping.complete(),
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


vim.diagnostic.config({
	virtual_text = true
})
