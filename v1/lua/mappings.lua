
vim.g.mapleader = " "

vim.cmd([[

" Re-Source nvim.lua
nnoremap <leader>;s :so ~/.config/nvim/init.lua<CR>

nnoremap <leader>;q :Ex<CR>

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

nnoremap <leader>e :NvimTreeToggle<CR>

nnoremap <leader>f :!prettyfier %<CR>
nnoremap <leader>s :%s/

nnoremap <leader>I :vertical:resize +5<CR>
nnoremap <leader>H :vertical:resize -5<CR>

nnoremap I :wincmd l<CR>
nnoremap H :wincmd h<CR>
nnoremap N :wincmd j<CR>
nnoremap E :wincmd k<CR>


" Colemak mappings
inoremap tn <esc>
" also possible for qwerty: fj


" down
noremap n j
noremap N J
"noremap j n
"noremap J N

" j/n problem fix: J for joining lines, m/M for search next/previous
noremap m n
noremap M N

" up
noremap e k
noremap E K
noremap k e
noremap K E

" With those mappings, e/E and b/B are next to each other, in a intuitive way

" left
noremap i l
"noremap I L
noremap l i
noremap L I

" right stays the same



]])

