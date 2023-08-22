
---------- Mappings ----------  

--- Colemak mappings {{{
vim.cmd[[
inoremap tn <esc>


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
nnoremap <silent> <Space>;q	:Lexplore 28<CR>
nnoremap <silent> <Space>;f	:Files<CR>
nnoremap <silent> <Space>l		:Lines<CR>
nnoremap <silent> gs				:Lines<CR>
nnoremap <silent> <Space>;g	:RG<CR>
nnoremap <silent> <Space>;b	:Buffers<CR>

nnoremap <silent> <Space>;v	:Vista<CR>
nnoremap <silent> <Space>;V	:Vista!<CR>

let g:limelight_conceal_ctermfg = 240
nnoremap <silent> <Space>;l :Limelight!!<CR>
nnoremap <silent> <Space>;L :Goyo<CR>
]]

--- Windows, buffers && co
vim.cmd[[
nnoremap <silent> <Space>q :q<CR>

" Wincmd mappings
nnoremap <silent> <Space>h :wincmd h<CR>
nnoremap <silent> <Space>n :wincmd j<CR>
nnoremap <silent> <Space>e :wincmd k<CR>
nnoremap <silent> <Space>i :wincmd l<CR>


" Resizing
noremap <silent> <C-left> :vertical res +5<CR>
noremap <silent> <C-down> :res +5<CR>
noremap <silent> <C-up>   :res -5<CR>
noremap <silent> <C-right> :vertical res -5<CR>


" Buffers
"<Space>;b -> :Buffers
noremap <silent> <C-e> :bn<CR>
noremap <silent> <C-n> :bp<CR>
nnoremap <silent> <Space>bn :bn<CR>
nnoremap <silent> <Space>bp :bp<CR>
nnoremap <silent> <Space>bk :bdelete<CR>


" Open header/source file
nnoremap gh :FSSplitRight<CR>
nnoremap gH :FSHere<CR>
]]

--- }}}


----------  Settings ---------- {{{
vim.cmd[[
set exrc

set foldenable foldmethod=marker

]]


--- Appearance

vim.cmd[[
set guifont=FiraCode\ Nerd\ Font\ Mono:h7

set guicursor=a:block-Cursor,i-ci:block-iCursor,r-cr:hor10
set list listchars=tab:--\|,trail:~,nbsp:×,multispace:---+

hi NonText ctermfg=DarkGrey guifg=DarkGrey

]]

--- Indents
vim.cmd[[
set et! ts=3 sts=3 sw=3
augroup USER_INDENT
	au!
	au BufNewFile,BufRead *.c,*.h					:setlocal et  sw=2 ts=2 sts=2
	au BufNewFile,BufRead *.cpp,*.hh,*.hpp		:setlocal et  sw=2 ts=2 sts=2
	au BufNewFile,BufRead Makefile				:setlocal et! sw=3 ts=3 sts=3
augroup END
]]


--- }}}



----------  Plugins ---------- {{{
vim.cmd[[
call plug#begin()
	Plug 'neovim/nvim-lspconfig'
	Plug 'liuchengxu/vista.vim'
   Plug 'vim-scripts/FSwitch'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	Plug 'junegunn/limelight.vim'
	Plug 'junegunn/goyo.vim'
	Plug 'sainnhe/sonokai'
   Plug 'ray-x/aurora'

	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

	Plug 'nvim-tree/nvim-web-devicons'
	Plug 'nvim-lua/plenary.nvim'
   Plug 'SirVer/ultisnips'
call plug#end()
]]
--- }}}


---------- Plugin Configuration ----------

--- Lsp {{{

--- LspConfig
local lspconfig = require 'lspconfig'
lspconfig.pyright.setup {}
lspconfig.clangd.setup {}
lspconfig.rust_analyzer.setup {
	settings = {
		['rust-analyzer'] = {},
	},
}

vim.keymap.set('n', '<space>d', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Space>;F', vim.lsp.buf.format)
vim.cmd 'map <C-,> :lua vim.lsp.omnifunc()<CR>'
vim.cmd 'map <C-k> :lua vim.lsp.buf.signature_help()<CR>'

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

" Netrw
let g:netrw_liststyle=3
]]

--- After
vim.cmd[[
set termguicolors
let g:sonokai_transparent_background = 1
if has("gui_running")
	colorscheme aurora
else
   colorscheme sonokai  " AFTER plugins
endif
]]


