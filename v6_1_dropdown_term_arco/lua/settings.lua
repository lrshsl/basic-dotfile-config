vim.cmd [[
set encoding=utf-8
set exrc

filetype plugin indent on
syntax enable

" Increment alphanumerical characters with <C-a> and <C-x>
"set nformats=alpha

" Appearance "
"set guifont=Source\ Code\ Pro\ Light:h7.5
set guifont=JetBrains\ Mono\ Thin:h7.5

"set colorcolumn=80

" Colors "
set termguicolors
let g:sonokai_transparent_background = 1
colorscheme sonokai  " AFTER other settings

set nowrap

" Tabs vs Spaces "
set noet ts=3 sts=3 sw=3

set foldmethod=marker
set list listchars=tab:-->,trail:~,leadmultispace:··\|,nbsp:¤

augroup TAB_VS_SPACES_AUGROUP
  autocmd!

  autocmd BufRead,BufWrite,BufNewFile Makefile          :setlocal list et! list listchars=tab:-->,trail:~,leadmultispace:··\|,nbsp:¤
  autocmd BufRead,BufWrite,BufNewFile Makefile          :echom "Makefile recognised. Now using tabs for indent"

  autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.hh,*.hpp   :setlocal et ts=2 sts=2 sw=2
  autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.hh,*.hpp   :setlocal list listchars=tab:->,trail:~,leadmultispace:·\|,nbsp:¤

  autocmd BufNewFile,BufRead *.nim                      :setlocal et ts=2 sts=2 sw=2
  autocmd BufNewFile,BufRead *.nim                      :setlocal list listchars=tab:->,trail:~,leadmultispace:·\|,nbsp:¤
augroup END
]]

--- Lambda that executes a vim command
function VimFn(cmd)
	return function()
		vim.cmd(cmd)
	end
end

BgTransparent = false
NumbersOn = false

function ToggleNumbers()
	if NumbersOn == true then
		NumbersOn = not NumbersOn
		vim.cmd [[ set nu! rnu! ]]
	else
		NumbersOn = not NumbersOn
		vim.cmd [[ set nu rnu ]]
	end
end

function ToggleTransparentBg()
	if BgTransparent == true then
		BgTransparent = not BgTransparent
		vim.cmd [[ hi Normal guibg=#111111 ctermbg=black ]]
	else
		BgTransparent = not BgTransparent
		vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]
	end
end

require 'which-key'.register {
	['<space>,'] = {
		name = 'Settings',
		b = {
			nwme = 'Background',
			t = { ToggleTransparentBg, 'Toggle transparency' },
		},
		n = { ToggleNumbers, 'Toggle line numbers' },
		w = {
			name = 'Whitespace',
			l = {
				name = 'List',
				l = { ':set list!<CR>', 'Toggle' },
				['2'] = { [[ :set listchars=tab:-->,trail:~,leadmultispace:·\|,nbsp:¤ <CR> ]], '2' },
				['3'] = { [[ :set listchars=tab:-->,trail:~,leadmultispace:··\|,nbsp:¤ <CR> ]], '3' },
				['4'] = { [[ :set listchars=tab:--->,trail:~,leadmultispace:···\|,nbsp:¤ <CR> ]], '4' },
			},
			s = { ':set et <CR>', 'Use spaces' },
			t = { ':set noet <CR>', 'Use tabs' },
			w = {
				name = 'Width of indentation',
				d = { ':set ts=3 sts=3 sw=3  <CR>', 'Default' },
				['1'] = { ':set ts=1 sts=1 sw=1 <CR>', '1' },
				['2'] = { ':set ts=2 sts=2 sw=2 <CR>', '2' },
				['3'] = { ':set ts=3 sts=3 sw=3 <CR>', '3' },
				['4'] = { ':set ts=4 sts=4 sw=4 <CR>', '4' },
				['8'] = { ':set ts=8 sts=8 sw=8 <CR>', '8' },
			}
		}
	}
}
