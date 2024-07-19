local wk = require 'which-key'
local telescope = require 'telescope.builtin'
local session_man = require 'session_manager'

wk.add {
	--> Leader mappings
	{
		--> File / Buffer navigation
		{ '<space>o',  '<cmd>Neotree toggle<cr>',               desc = 'File Tree' },

		--> Find
		{ '<space>f',  group = 'find' },
		{ '<space>fd', telescope.diagnostics,                   desc = 'Find diagnostics' },
		{ '<space>fr', telescope.lsp_references,                desc = 'Find References' },
		{ '<space>fh', telescope.help_tags,                     desc = 'Find Help' },

		{ '<space>fg', telescope.live_grep,                     desc = 'Live grep' },

		{ '<space>fa', telescope.find_files,                    desc = 'Find All Files' },
		{ '<space>ft', telescope.buffers,                       desc = 'Find Buffers' },
		{ '<space>fo', telescope.oldfiles,                      desc = 'Open Recent File' },

		{ '<space>fs', telescope.lsp_document_symbols,          desc = 'Find Document Symbols' },
		{ '<space>fS', telescope.symbols,                       desc = 'Symbols' },
		{ '<space>fw', telescope.lsp_dynamic_workspace_symbols, desc = 'Workspace Symbols' },

		--> Session
		{ '<space>s',  group = 'session' },
		{ '<space>ss', session_man.save_current_session,        desc = 'Save Session' },
		{ '<space>sl', session_man.load_session,                desc = 'Load Session' },
		{ '<space>sL', session_man.load_last_session,           desc = 'Load Last Session' },
		{ '<space>sd', session_man.delete_session,              desc = 'Delete Session' },

		--> Lsp
		{ '<space>c',  group = 'code' },
		{ '<space>ca', vim.lsp.buf.code_action,                 desc = 'Code Action' },
		{ '<space>cr', vim.lsp.buf.rename,                      desc = 'Rename' },
		{ '<space>ch', vim.lsp.buf.hover,                       desc = 'Hover' },
		{ '<space>cf', vim.lsp.buf.format,                      desc = 'Format' },

		--> Text editing
		{ '<space>u',  'viw~',                                  desc = 'lower <-> UPPER' },
		{ '<space>U',  'viw~',                                  desc = 'lower-word <-> UPPER-WORD' },
		{ '<space>y',  '~h',                                    desc = '~' },

		--> Buffer
		{ '<space>w',  ':w<CR>',                                desc = 'write buffer' },
		{ '<space>q',  ':q<CR>',                                desc = 'quit buffer' },
		{ '<space>;w', ':wa<CR>',                               desc = 'write all' },
		{ '<space>;q', ':xa<CR>',                               desc = 'quit all' },

		--> Search and replace
		{
			mode = { 'n' },
			{ '<space>s', ':%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>',
				desc = 'Search and replace (cursor)' },
			{ '<space>;s', ':%s//gc<Left><Left><Left>', desc = 'Search and replace' },
		},
		{
			mode = { 'v' },
			{ '<space>s',  ':s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>', desc = 'Search and replace (cursor)' },
			{ '<space>;s', ':s//g<Left><Left>',                      desc = 'Search and replace' },
		},
	},

	--> Non prefix mappings
	{
		mode = { 'n', 'v' },
		{ 'j', desc = 'which_key_ignore' }, -- Colemak remaps
		{ 'h', desc = 'Left' },
		{ 'n', desc = 'Down' },
		{ 'e', desc = 'Up' },
		{ 'i', desc = 'Right' },
		{ 'l', desc = 'Insert' },
		{ 'k', desc = 'End of word' },
		{ 'H', desc = 'Start of line (non-blank)' },
		{ 'I', desc = 'End of line' },

		{ '$', desc = 'which_key_ignore' }, -- Shift-mappings
		{ '^', desc = 'which_key_ignore' },
		{ '_', desc = 'which_key_ignore' },
		{ '0', desc = 'Start of line' },
	},

	--> Insert mode mappings
	{
		mode = { 'i' },
		name = 'Abbreviations',
		{ ';ae',  'ä',            desc = 'ä', },
		{ ';Ae',  'Ä',            desc = 'Ä', },
		{ ';AE',  'Ä',            desc = 'Ä', },

		{ ';oe',  'ö',            desc = 'ö', },
		{ ';Oe',  'Ö',            desc = 'Ö', },
		{ ';OE',  'Ö',            desc = 'Ö', },

		{ ';ue',  'ü',            desc = 'ü', },
		{ ';Ue',  'Ü',            desc = 'Ü', },
		{ ';UE',  'Ü',            desc = 'Ü', },

		{ ';str', "&'static str", desc = "&'static str" },
		{ ';l',   "'",            desc = "lifetime tick (')" }, -- Lifetimes (and still getting auto-close for '')
	}
}

-- wk.show{
-- 	keys = '<C-w>',
-- 	loop = true,
-- } -- ??
--
--> Resize splits with arrow keys
Nmap('<C-up>', ':res +5<CR>')
Nmap('<C-down>', ':res -5<CR>')
Nmap('<C-left>', ':vertical resize-5<CR>')
Nmap('<C-right>', ':vertical resize+5<CR>')

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

--> Code/text actions
Nmap('<space>;r', ':!')

vim.cmd [[

" Usable scrolling for non-vim people
 set mouse=a
 noremap <ScrollWheelUp> <C-Y>
 noremap <ScrollWheelDown> <C-E>

" Paste in all modes and editors (neovide) "

" Paste: Emulate middle mouse click
inoremap <C-v> <MiddleMouse>
tnoremap <C-v> <MiddleMouse>

" Paste: Emulate middle mouse click
nnoremap <C-S-v> "+p
inoremap <C-S-v> <C-o>"+p
"tnoremap <C-S-v> <esc>"+pa

" Paste: Yank to clipboard in visual with Y "
vnoremap <space>y "+y
vnoremap Y "+y


" Scroll using Ctrl "
noremap <C-e> 5<C-e>
noremap <C-n> 5<C-y>

" <C-u> is already mapped
noremap <C-y> <C-d>

]]

--vim.cmd " map [[ [{ "
--vim.cmd " map ]] [}<CR> "

vim.cmd [[
" Move to line
"map <space>l <Plug>(easymotion-bd-jk)
"nmap <space>l <Plug>(easymotion-overwin-line)

" Move to word
"map  <space>w <Plug>(easymotion-bd-w)
"nmap <space>w <Plug>(easymotion-overwin-w)

" Run commands "
nnoremap <space>rr :!
nnoremap <space>rs :so ~/.config/nvim/init.lua
nnoremap <space>rm :make<space>

nnoremap <space>ra :lua ToggleTerminal()<CR>
nnoremap <space>rf :lua ToggleTerminal()<CR>

augroup CMD_RUN
   autocmd!

   " Rust "
   autocmd BufReadPre *.rs,Cargo.*               nnoremap <space>ra   :!cargo r --<space>
   autocmd BufReadPre *.rs,Cargo.*               nnoremap <space>rf   :!rustc -o rs.out % && ./rs.out

   " Make | CMake | C | C++ "
   autocmd BufNewFile,BufRead *.c,*.h,Makefile   nnoremap <space>ra   :!make<space>
   autocmd BufNewFile,BufRead *.cpp,*.hh,*.hpp   nnoremap <space>ra   :!make<space>
   autocmd BufNewFile,BufRead *.c,*.h            nnoremap <space>rf   :!gcc -Wall -Wextra -std=c11 -pedantic -o c.out % ; ./c.out
   autocmd BufNewFile,BufRead *.cpp,*.hh,*.hpp   nnoremap <space>rf   :!g++ -Wall -Wextra -std=c++17 -pedantic -o a.out % ; ./a.out

   " Python, js, go "
   autocmd BufNewFile,BufRead *.py               nnoremap <space>ra   :!python main.py
   autocmd BufNewFile,BufRead *.py               nnoremap <space>rf   :!python %
   autocmd BufNewFile,BufRead *.js               nnoremap <space>ra   :!node<space>
   autocmd BufNewFile,BufRead *.go               nnoremap <space>ra   :!go run<space>

   " Lua | Vim "
   autocmd BufNewFile,BufRead *.lua               nnoremap <space>ra   :!lua<space>
   autocmd BufNewFile,BufRead *.lua,*.vim         nnoremap <space>rf   :so %

   " Nim "
   autocmd BufNewFile,BufRead *.nim               nnoremap <space>ra   :!nimble run --<space>
   autocmd BufNewFile,BufRead *.nim               nnoremap <space>rf   :!nim c -r %

   " Java && Gradle "
   autocmd BufNewFile,BufRead *.java            nnoremap <space>ra   :!gradle deploy
   autocmd BufNewFile,BufRead *.java            nnoremap <space>rb   :!gradle build

   " Br*infuck "
   autocmd BufNewFile,BufRead *.bf               nnoremap <space>ra   :!bf % && ./a.out

	" Assembly "
	autocmd BufNewFile,BufRead *.asm              nnoremap <space>ra   :!make && ./a.out
	autocmd BufNewFile,BufRead *.asm              nnoremap <space>rf   :!nasm -f elf64 -o out.o % && ld -o out out.o && ./out

   " Markdown -> PDF "
   autocmd BufNewFile,BufRead *.md,*.tex         nnoremap <space>ra   :!pandoc % -o out.pdf
augroup END

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

" Needed for some reason
nnoremap cl cl

" Alias beginning and end of line "
noremap <silent> H ^
noremap <silent> I <end>

" Jump Up/Down with Shift "
noremap N 5<down>
noremap E 5<up>


"
inoremap <C-h> <C-o><Left>
inoremap <C-i> <right>
"inoremap <C-e> <up>
"inoremap <C-n> <down>

]]
