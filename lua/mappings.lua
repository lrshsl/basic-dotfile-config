vim.cmd([[

nnoremap <silent> <space>q :qa<CR>
nnoremap <silent> <space>w :wa<CR>
nnoremap <silent> <Space><Space> :FZF<CR>
nnoremap <silent> <A-o> :FZF<CR>

" Window Movement
noremap <silent> <S-h> :wincmd h<CR>
noremap <silent> <S-l> :wincmd l<CR>


augroup CMD_RUN
    autocmd!
    autocmd BufReadPre *.rs,Cargo.* nnoremap <space>r :!cargo run<CR>
    autocmd BufNewFile,BufRead *.py nnoremap <space>r :!python main.py<CR>
augroup END

]])
