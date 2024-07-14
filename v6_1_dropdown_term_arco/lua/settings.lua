vim.cmd [[
set encoding=utf-8
set exrc

filetype plugin indent on
syntax enable

" Increment alphanumerical characters with <C-a> and <C-x>
set nrformats=alpha

" Ligature test: -> 1/2 >= 0 |>

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
set listchars=tab:-->,trail:~,leadmultispace:··\|,nbsp:¤

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

BgTransparent = false
NumbersOn = false

function ToggleNumbers()
	if NumbersOn == true then
		NumbersOn = not NumbersOn
		vim.opt.number = NumbersOn
		vim.cmd [[ set nu! rnu! ]]
	else
		NumbersOn = not NumbersOn
		vim.cmd [[ set nu rnu ]]
	end
end

function SetFontSizeCurry(val)
	return function()
		vim.opt.guifont = "JetBrains Mono Thin:h" .. val
	end
end

function BgSetTransparencyCurry(val)
	if vim.g.neovide then
		return function()
			vim.g.neovide_transparency = 1 - val
		end
	end
	return function()
		print('No known gui detected, transparency might not work properly')
		if val > 0.5 then
			vim.cmd [[ hi Normal guibg=#111111 ctermbg=black ]]
		else
			vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]
		end
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

require 'which-key'.register { --- [which-key-bindings] Settings
	['<space>,'] = {
		name = 'Settings',
		v = { ':Vista!!<CR>', 'Vista' },
		l = { ':Limelight!!<CR>', 'Limelight' },
		g = { ':Goyo 90%x50%<CR>', 'Goyo' },
		G = { ':Goyo<CR>', 'Goyo (deactivate)' },
		n = { ToggleNumbers, 'Toggle line numbers' },
		b = {
			name = 'Background',
			b = { ToggleTransparentBg, 'Toggle transparency' },
			t = {
				name = 'Transparency',
				['`'] = { BgSetTransparencyCurry(0.0), '0' },
				['1'] = { BgSetTransparencyCurry(0.1), '1' },
				['2'] = { BgSetTransparencyCurry(0.2), '2' },
				['3'] = { BgSetTransparencyCurry(0.3), '3' },
				['4'] = { BgSetTransparencyCurry(0.4), '4' },
				['5'] = { BgSetTransparencyCurry(0.5), '5' },
				['6'] = { BgSetTransparencyCurry(0.6), '6' },
				['7'] = { BgSetTransparencyCurry(0.7), '7' },
				['8'] = { BgSetTransparencyCurry(0.8), '8' },
				['9'] = { BgSetTransparencyCurry(0.9), '9' },
				['0'] = { BgSetTransparencyCurry(1.0), '10' },
			}
		},
		f = {
			name = 'Font',
			['`'] = { SetFontSizeCurry(6), '6' },
			['1'] = { SetFontSizeCurry(7), '7' },
			['2'] = { SetFontSizeCurry(8), '8' },
			['3'] = { SetFontSizeCurry(9), '9' },
			['4'] = { SetFontSizeCurry(10), '10' },
			['5'] = { SetFontSizeCurry(11), '11' },
			['6'] = { SetFontSizeCurry(12), '12' },
			['7'] = { SetFontSizeCurry(13), '13' },
			['8'] = { SetFontSizeCurry(16), '16' },
			['9'] = { SetFontSizeCurry(20), '20' },
			['0'] = { SetFontSizeCurry(30), '30' },
		},
		w = {
			name = 'Whitespace',
			l = {
				name = 'List',
				l = { ':set list!<CR>', 'Toggle' },
				['2'] = { [[ :set listchars=tab:-->,trail:~,leadmultispace:·\|,nbsp:¤ <CR> ]], '2' },
				['3'] = { [[ :set listchars=tab:-->,trail:~,leadmultispace:··\|,nbsp:¤ <CR> ]], '3' },
				['4'] = { [[ :set listchars=tab:-->,trail:~,leadmultispace:··\|,nbsp:¤ <CR> ]], '4' },
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
				n = { ToggleNumbers, 'Toggle line numbers' },
			}
		}
	}
}
