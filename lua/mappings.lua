vim.cmd([[

inoremap fj <esc>

nnoremap <silent> <space>q :qa<CR>
nnoremap <silent> <space>w :wa<CR>

nnoremap <silent> <Space><Space> :FZF<CR>
nnoremap <silent> <A-o> :FZF<CR>

" Window Movement
noremap <silent> <S-h> :wincmd h<CR>
"noremap <silent> <S-l> :wincmd l<CR>
noremap <silent> <S-i> :wincmd l<CR>


augroup CMD_RUN
    autocmd!
    autocmd BufReadPre *.rs,Cargo.* nnoremap <space>r :!cargo run<CR>
    autocmd BufNewFile,BufRead *.py nnoremap <space>r :!python main.py<CR>
    autocmd BufReadPre *.c,*.h,*.cpp,*.hh,*.hpp nnoremap <space>r :!make run<CR>
augroup END


" Convenience
inoremap <C-BS> <C-o>


" Colemak mappings

inoremap tn <esc>

nnoremap n j
nnoremap e k
nnoremap k e
nnoremap K E
nnoremap i l

nnoremap l i
nnoremap L I

vnoremap n j
vnoremap e k
vnoremap k e
vnoremap i l

vnoremap l i

nnoremap dn dj
nnoremap de dk

]])
