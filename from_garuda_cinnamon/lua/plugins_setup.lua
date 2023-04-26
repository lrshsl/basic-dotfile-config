-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<space>;m", mark.add_file)
vim.keymap.set("n", "<space>m", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-e>", function()
	ui.nav_next(1)
end)
vim.keymap.set("n", "<C-n>", function()
	ui.nav_prev(2)
end)

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<space>;f", builtin.find_files, {})
vim.keymap.set("n", "<space>;g", builtin.live_grep, {})
vim.keymap.set("n", "<space>b", builtin.buffers, {})

-- Lsp Zero
local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(_, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

lsp.format_on_save({
	format_opts = {
		timeout_ms = 0,
	},

	servers = {

		["null-ls"] = { "javascript", "typescript", "lua" },
	},
})

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

--After lsp-zero
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })

cmp.setup({
	preselect = "item",
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	mapping = {
		-- ['<tab>'] = cmp.mapping.confirm({select = false}),
		-- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
		-- ['<C-b>'] = cmp_action.luasnip_jump_backward(),
		["<Tab>"] = cmp_action.luasnip_supertab(),
		["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
	},
})

vim.keymap.set("n", "<space>d", vim.diagnostic.open_float)

-- Mason && null-ls
require("mason").setup()
require("mason-null-ls").setup({
	automatic_installation = false,
	automatic_setup = true,
})
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
	sources = {
		-- Anything not supported by mason.
	},
	-- Format on save:
	-- -- you can reuse a shared lspconfig on_attach callback here
	-- on_attach = function(client, bufnr)
	-- 	if client.supports_method("textDocument/formatting") then
	-- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	-- 		vim.api.nvim_create_autocmd("BufWritePre", {
	-- 			group = augroup,
	-- 			buffer = bufnr,
	-- 			callback = function()
	-- 				vim.lsp.buf.format({ bufnr = bufnr })
	-- 			end,
	-- 		})
	-- 	end
	-- end,
})

require("mason-null-ls").setup_handlers()

-- NvimTree
vim.opt.termguicolors = true

require("nvim-tree").setup({
	filters = {
		dotfiles = true,
	},
})

-- TODO: Setup NvimTree
-- vim.keymap.set('n', '<space>o', vim.cmd.NvimTreeToggle)

local prettier = require("prettier")

prettier.setup({
	bin = "prettier",
	filetypes = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"less",
		"markdown",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
	},
})



