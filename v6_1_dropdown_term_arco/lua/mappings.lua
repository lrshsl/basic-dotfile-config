local wk = require("which-key")

--> Prefix mappings
wk.register({
    --> File
    f = {
        name = "file",
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        a = { "<cmd>Telescope find_files<cr>", "Find All Files" },
        t = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    },
    --> Session
    s = {
        name = "session",
        s = { "<cmd>SessionManager save_current_session<cr>", "Save Session" },
        l = { "<cmd>SessionManager load_session<cr>", "Load Session" },
        L = { "<cmd>SessionManager load_last_session<cr>", "Load Last Session" },
        d = { "<cmd>SessionManager delete_session<cr>", "Delete Session" },
    },
    --> Lsp
    c = {
        name = "code",
        r = { vim.lsp.buf.rename, "Rename" },
        h = { vim.lsp.buf.hover, "Hover" },
        s = { "<cmd>Telescope symbols<cr>", "Search Symbols" },
        S = { "<cmd>Telescope lsp_document_symbols<cr>", "Search Document Symbols" },
    },
    --> File / Buffer navigation
    o = { "<cmd>Neotree toggle<cr>", "File Tree" },

    --> Text editing
    u = { "viw~", "lower <-> UPPER" },
    U = { "viw~", "lower-word <-> UPPER-WORD" },
    y = { "~h", "~" },

    --> 

    --> Buffer
    w = "write buffer",
    q = "quit buffer",
}, { prefix = "<leader>" })

--> Non prefix mappings
wk.register {
    j = "which_key_ignore", -- Colemak remaps
    h = "Left",
    n = "Down",
    e = "Up",
    i = "Right",
    l = "Insert",
    k = "End of word",
    ["$"] = "which_key_ignore", -- Shift-mappings
    ["^"] = "which_key_ignore",
    ["_"] = "which_key_ignore",
    ["0"] = "Start of line",
    H = "Start of line (non-blank)",
    I = "End of line"
}

--> LSP
Imap('<C-space>', vim.lsp.buf.completion)

--Nmap('<space>u', 'viw~')
--Nmap('<space>U', 'viW~')

--> Search and replace
Nmap('<space>s', ':%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>')
Vmap('<space>s', ':s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>')
Nmap('<space>;s', ':%s//gc<Left><Left><Left>')
Vmap('<space>;s', ':s//g<Left><Left>')

--> File / Buffer write and close
Nmap('<space>w', ':w<CR>')
Nmap('<space>;w', ':wa<CR>')
Nmap('<space>q', ':q<CR>')
Nmap('<space>;q', ':qa<CR>')

--> Terminal
require 'dropdown_terminal'

-- Map a key to toggle the terminal
vim.keymap.set('n', '<leader>t', ToggleTerminal, { noremap = true, silent = true })
vim.keymap.set('t', 'tn', ToggleTerminal, { noremap = true, silent = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

--> Window navigation
Nmap('<space>i', ':wincmd l<CR>')
Nmap('<space>h', ':wincmd h<CR>')
Nmap('<space>n', ':wincmd j<CR>')
Nmap('<space>e', ':wincmd k<CR>')

--> Fuzzy finding
--Nmap('<leader>ft', ':Telescope buffers<CR>')
--Nmap('<space>fa', ':Telescope find_files<CR>')
--Nmap('<leader>fg', ':Telescope live_grep<CR>')
--Nmap('<leader>fh', ':Telescope help_tags<CR>')
--Nmap('<leader>fs', ':Telescope symbols<CR>')

--> Code/text actions
Nmap('<space>F', ':LspZeroFormat<CR>')
Nmap('<space>,v', ':Vista<CR>')
Nmap('<space>,l', ':Limelight<CR>')
Nmap('<space>,L', ':Limelight!<CR>')
Nmap('<space>,g', ':Goyo 90%x50%<CR>')
Nmap('<space>,G', ':Goyo')

Nmap('<space>r', ':!')

vim.cmd([[

" Usable scrolling for non-vim people
 set mouse=a
 noremap <ScrollWheelUp> <C-Y>
 noremap <ScrollWheelDown> <C-E>

" Scroll using Ctrl "
" <C-e> is already mapped
noremap <C-n> <C-y>
" <C-u> is already mapped
noremap <C-y> <C-d>


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

    autocmd BufNewFile,BufRead *.py nnoremap <space>;r :!python %
	autocmd BufNewFile,BufRead *.js nnoremap <space>;r :!node<space>
	autocmd BufNewFile,BufRead *.go nnoremap <space>;r :!go run<space>
	autocmd BufNewFile,BufRead *.lua nnoremap <space>;r :!lua<space>

	autocmd BufNewFile,BufRead *.nim nnoremap <space>;r :!nimble run<space>
	autocmd BufNewFile,BufRead *.nim nnoremap <space>;R :!nim c -r %

    autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.hh,*.hpp,Makefile nnoremap <space>;r :!make<space>
    autocmd BufNewFile,BufRead *.c,*.h nnoremap <space>;R :!gcc -Wall -Wextra -std=c99 -pedantic -o c.out % ; ./c.out
	autocmd BufNewFile,BufRead *.cpp,*.hh,*.hpp nnoremap <space>;R :!g++ -Wall -Wextra -std=c++17 -pedantic -o a.out % ; ./a.out

	autocmd BufNewFile,BufRead *.java nnoremap <space>;r :!gradle deploy
	autocmd BufNewFile,BufRead *.java nnoremap <space>;B :!gradle build

	autocmd BufNewFile,BufRead *.bf nnoremap <space>;r :!bf % && ./a.out

	autocmd BufNewFile,BufRead *.md nnoremap <space>;r :!pandoc % -o out.pdf
augroup END

" Resize splits with arrow keys
noremap <C-up> :res +5<CR>
noremap <C-down> :res -5<CR>
noremap <C-left> :vertical resize-5<CR>
noremap <C-right> :vertical resize+5<CR>

" Codeium "
"imap <script><silent><nowait><expr> <C-y> codeium#Accept()
imap <C-;>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-:>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-[>   <Cmd>call codeium#Clear()<CR>

" Correct last spelling mistake "
imap <C-l> <C-g>u<esc>[s1z=`]a<C-g>u

" Colemak Mappings
inoremap tn <esc>
inoremap TN <esc>

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
inoremap ;ae ä
inoremap ;oe ö
inoremap ;ue ü
inoremap ;Ae Ä
inoremap ;Oe Ö
inoremap ;Ue Ü

" Alias beginning and end of line "
noremap <silent> H ^
noremap <silent> I <end>

" Jump Up/Down with Shift "
noremap N 5<down>
noremap E 5<up>


"
inoremap <C-h> <C-o><left>
inoremap <C-i> <right>
"inoremap <C-e> <up>
"inoremap <C-n> <down>

]])
