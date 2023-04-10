
-- Harpoon
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vim.keymap.set('n', '<space>m', mark.add_file)
vim.keymap.set('n', '<space>o', ui.toggle_quick_menu)

vim.keymap.set('n', '<C-e>', function() ui.nav_next(1) end)
vim.keymap.set('n', '<C-n>', function() ui.nav_prev(2) end)



-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<space>;f', builtin.find_files, {})
vim.keymap.set('n', '<space>;g', builtin.live_grep, {})
vim.keymap.set('n', '<space>b', builtin.buffers, {})



-- Lsp Zero
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

