
vim.g.mapleader = " "

vim.cmd([[

" Re-Source nvim.lua
nnoremap <leader>;s :so ~/.config/nvim/init.lua<CR>

nnoremap <leader>;q :Lexplore<CR>

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>


" Colemak mappings
inoremap tn <esc>

nnoremap N 10j
nnoremap E 10k

noremap n j
"noremap N J
noremap j n
"noremap J N

noremap e k
noremap E K
noremap k e
noremap K E

noremap i l
noremap I L
noremap l i
noremap L I


]])

