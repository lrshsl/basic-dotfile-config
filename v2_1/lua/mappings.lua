vim.keymap.set('i', '<C-,>', function()
	vim.lsp.buf.completion()
end, { expr = false })


vim.cmd([[

nnoremap <silent> <space>q :q<CR>
nnoremap <silent> Q :qa<CR>
nnoremap <silent> <space>;w :wa<CR>
nnoremap <silent> <space>;q :NvimTreeToggle<CR>
" Don't forget harpoon mappings "

nnoremap <silent> <space>;f :FZF<CR>
nnoremap <silent> <space>F  :LspZeroFormat<CR>
nnoremap <silent> <space>;v :Vista<CR>
nnoremap <silent> <space>;l :Limelight<CR>
nnoremap <silent> <space>;L :Limelight!<CR>

" Window Movement
" Qwerty
"noremap <silent> <space>l :wincmd l<CR>
" Colemak
nnoremap <silent> <space>i :wincmd l<CR>
nnoremap <silent> <space>h :wincmd h<CR>
nnoremap <silent> <space>n :wincmd j<CR>
nnoremap <silent> <space>e :wincmd k<CR>


" EasyMotion
" <Leader>f{char} to move to {char}
map  <space>f <Plug>(easymotion-bd-f)
nmap <space>f <Plug>(easymotion-overwin-f)

" zz{char}{char} to move to {char}{char}
nmap zz <Plug>(easymotion-overwin-f2)

" Move to line
map <space>l <Plug>(easymotion-bd-jk)
nmap <space>l <Plug>(easymotion-overwin-line)

" Move to word
map  <space>w <Plug>(easymotion-bd-w)
nmap <space>w <Plug>(easymotion-overwin-w)


" Run commands "
nnoremap <space>r :!
augroup CMD_RUN
    autocmd!
    autocmd BufReadPre *.rs,Cargo.* nnoremap <space>;r :!cargo r
    autocmd BufReadPre *.rs,Cargo.* nnoremap <space>;R :!rustc -o rs.out % && ./rs.out
    autocmd BufNewFile,BufRead *.py nnoremap <space>;r :!python<space>
	autocmd BufNewFile,BufRead *.js nnoremap <space>;r :!node<space>
	autocmd BufNewFile,BufRead *.go nnoremap <space>;r :!go run<space>
	autocmd BufNewFile,BufRead *.lua nnoremap <space>;r :!lua<space>
    autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.hh,*.hpp,Makefile nnoremap <space>;r :!make<space>
    autocmd BufNewFile,BufRead *.c,*.h nnoremap <space>;R :!gcc -Wall -Wextra -std=c99 -pedantic -o c.out % ; ./c.out
	autocmd BufNewFile,BufRead *.cpp,*.hh,*.hpp nnoremap <space>;R :!g++ -Wall -Wextra -std=c++17 -pedantic -o a.out % ; ./a.out
augroup END

" Resize splits with arrow keys
noremap <C-up> :res +5<CR>
noremap <C-down> :res -5<CR>
noremap <C-left> :vertical resize-5<CR>
noremap <C-right> :vertical resize+5<CR>


" Codeium "
imap <script><silent><nowait><expr> <Tab> codeium#Accept()
imap <C-;>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-:>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-[>   <Cmd>call codeium#Clear()<CR>

" Colemak Mappings
inoremap tn <esc>

nnoremap m n
nnoremap M N

noremap n j
noremap e k
noremap k e
noremap E K
noremap K E

noremap i l
noremap l i
noremap I L
noremap L I

" For writing Umlauts "
inoremap ae ä
inoremap oe ö
inoremap ue ü
inoremap <S-a>e Ä
inoremap <S-o>e Ö
inoremap <S-u>e Ü

" Alias beginning and end of line "
noremap <silent> H ^
noremap <silent> I <end>

" Jump Up/Down with Shift "
noremap N 5<down>
noremap E 5<up>

" Scroll using Ctrl "
noremap <C-n> <C-y>
noremap <C-S-n> 5<C-y>
noremap <C-S-e> 5<C-e>


"
inoremap <C-h> <C-o><left>
inoremap <C-i> <right>
inoremap <C-e> <up>
inoremap <C-n> <down>

]])
