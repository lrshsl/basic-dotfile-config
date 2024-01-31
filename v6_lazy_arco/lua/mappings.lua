
Imap('<C-space>', vim.lsp.buf.completion)

Nmap('<space>u', 'viw~')
Nmap('<space>U', 'viW~')

Nmap('<space>q', ':q<CR>')
Nmap('Q', ':qa<CR>')
Nmap('<space>;w', ':wa<CR>')
Nmap('<space>;q', ':NvimTreeToggle<CR>')

Nmap('<space>;f', ':Telescope find_files<CR>')
Nmap('<space>F', ':LspZeroFormat<CR>')
Nmap('<space>;v', ':Vista<CR>')
Nmap('<space>;l', ':Limelight<CR>')
Nmap('<space>;L', ':Limelight!<CR>')

Nmap('<space>i', ':wincmd l<CR>')
Nmap('<space>h', ':wincmd h<CR>')
Nmap('<space>n', ':wincmd j<CR>')
Nmap('<space>e', ':wincmd k<CR>')

Nmap('<space>r', ':!')

vim.cmd([[

" Move to line
"map <space>l <Plug>(easymotion-bd-jk)
"nmap <space>l <Plug>(easymotion-overwin-line)

" Move to word
"map  <space>w <Plug>(easymotion-bd-w)
"nmap <space>w <Plug>(easymotion-overwin-w)


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

	autocmd BufNewFile,BufRead *.java nnoremap <space>;r :!gradle build
augroup END

" Resize splits with arrow keys
noremap <C-up> :res +5<CR>
noremap <C-down> :res -5<CR>
noremap <C-left> :vertical resize-5<CR>
noremap <C-right> :vertical resize+5<CR>

" Codeium "
imap <script><silent><nowait><expr> <C-y> codeium#Accept()
imap <C-;>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-:>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-[>   <Cmd>call codeium#Clear()<CR>

" Correct last spelling mistake "
imap <C-l> <C-g>u<esc>[s1z=`]a<C-g>u

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
