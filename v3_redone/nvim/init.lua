vim.cmd[[

inoremap tn <esc>

]]

---------- Mappings ----------  

--- Colemak mappings {{{
vim.cmd[[
noremap n <down>
noremap N 5<down>

noremap e <up>
noremap E 5<up>

noremap i <right>
noremap I $

noremap H ^

noremap l i
noremap L I

noremap k e
noremap K E

noremap m n
noremap M N

]]

--- }}}

--- Other shortcuts {{{

--- Launching
vim.cmd[[
nnoremap <Space>;q :Lexplore 28<CR>
nnoremap <Space>;f :FZF<CR>
nnoremap <Space>;g :TelescopeGrep<CR>
nnoremap <Space>;v :Vista<CR>

let g:limelight_conceal_ctermfg = 240
nnoremap <Space>;l :Limelight!!<CR>
nnoremap <Space>;L :Goyo<CR>
]]

--- Windows, buffers && co
vim.cmd[[
nnoremap <Space>q :q<CR>

" wincmd mappings
nnoremap <Space>h :wincmd h<CR>
nnoremap <Space>n :wincmd j<CR>
nnoremap <Space>e :wincmd k<CR>
nnoremap <Space>i :wincmd l<CR>


" resizing
noremap <silent> <C-left> :vertical res +5<CR>
noremap <silent> <C-down> :res +5<CR>
noremap <silent> <C-up>   :res -5<CR>
noremap <silent> <C-right> :vertical res -5<CR>
]]

--- }}}


----------  Settings ---------- {{{
vim.cmd[[
set exrc

set foldenable foldmethod=marker

]]

--- Appearance

vim.cmd[[
set guicursor=a:block-Cursor,i-ci:block-iCursor,r-cr:hor10
]]


--- }}}



----------  Plugins ---------- {{{
vim.cmd[[
call plug#begin()
	Plug 'neovim/nvim-lspconfig'
	Plug 'liuchengxu/vista.vim'
	Plug 'junegunn/limelight.vim'
	Plug 'junegunn/goyo.vim'
call plug#end()
]]
--- }}}


---------- Plugin Configuration ----------

--- Lsp {{{

--- LspConfig
local lspconfig = require 'lspconfig'
lspconfig.pyright.setup {}
lspconfig.rust_analyzer.setup {
	settings = {
		['rust-analyzer'] = {},
	},
}

vim.keymap.set('n', '<space>d', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Completion on <C-x><C-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		vim.keymap.set('i', '<C-Space>', vim.lsp.omnifunc)

		-- Mappings for buffers with attached language server
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', 'j', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)


		vim.keymap.set('n', '<Space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<Space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<Space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)

		vim.keymap.set('n', '<Space>r', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<Space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<Space>F', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end

})

--- }}}

--- Small stuff
vim.cmd[[
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
]]


