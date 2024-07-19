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

set guicursor=n-v-c-sm-i-ci-ve:block,r-cr-o:hor20

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
		vim.cmd [[ set nu! rnu! ]]
	else
		vim.cmd [[ set nu rnu ]]
	end
	NumbersOn = not NumbersOn
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

--> Settings bindings
require 'which-key'.add {
	group = 'Settings',
	{ '<space>,v', ':Vista!!<CR>',      desc = 'Vista' },
	{ '<space>,l', ':Limelight!!<CR>',  desc = 'Limelight' },
	{ '<space>,g', ':Goyo 70%x90%<CR>', desc = 'Goyo' },
	{ '<space>,G', ':Goyo<CR>',         desc = 'Goyo (deactivate)' },
	{ '<space>,n', ToggleNumbers,       desc = 'Toggle line numbers' },
	{
		group = 'Transparency',
		{ '<space>,bb',  ToggleTransparentBg,          desc = 'Toggle transparency' },
		{ '<space>,bt`', BgSetTransparencyCurry(0),    desc = '0' },
		{ '<space>,bt1', BgSetTransparencyCurry(0.03), desc = '1' },
		{ '<space>,bt2', BgSetTransparencyCurry(0.05), desc = '2' },
		{ '<space>,bt3', BgSetTransparencyCurry(0.08), desc = '3' },
		{ '<space>,bt4', BgSetTransparencyCurry(0.15), desc = '4' },
		{ '<space>,bt5', BgSetTransparencyCurry(0.2),  desc = '5' },
		{ '<space>,bt6', BgSetTransparencyCurry(0.3),  desc = '6' },
		{ '<space>,bt7', BgSetTransparencyCurry(0.5),  desc = '7' },
		{ '<space>,bt8', BgSetTransparencyCurry(0.75), desc = '8' },
		{ '<space>,bt9', BgSetTransparencyCurry(0.9),  desc = '9' },
		{ '<space>,bt0', BgSetTransparencyCurry(1.0),  desc = '10' },
	},
	{
		group = 'Font',
		{ '<space>,f`', SetFontSizeCurry(6),  desc = '6' },
		{ '<space>,f1', SetFontSizeCurry(7),  desc = '7' },
		{ '<space>,f2', SetFontSizeCurry(8),  desc = '8' },
		{ '<space>,f3', SetFontSizeCurry(9),  desc = '9' },
		{ '<space>,f4', SetFontSizeCurry(10), desc = '10' },
		{ '<space>,f5', SetFontSizeCurry(11), desc = '11' },
		{ '<space>,f6', SetFontSizeCurry(12), desc = '12' },
		{ '<space>,f7', SetFontSizeCurry(13), desc = '13' },
		{ '<space>,f8', SetFontSizeCurry(16), desc = '16' },
		{ '<space>,f9', SetFontSizeCurry(20), desc = '20' },
		{ '<space>,f0', SetFontSizeCurry(30), desc = '30' },
	},
	{
		group = 'Whitespace',
		{
			group = 'List',
			{ 'l',           ':set list!<CR>',                                                      desc = 'Toggle' },
			{ '<space>,wl2', [[ :set listchars=tab:-->,trail:~,leadmultispace:·\|,nbsp:¤ <CR> ]],   desc = '2' },
			{ '<space>,wl3', [[ :set listchars=tab:-->,trail:~,leadmultispace:··\|,nbsp:¤ <CR> ]],  desc = '3' },
			{ '<space>,wl4', [[ :set listchars=tab:-->,trail:~,leadmultispace:···\|,nbsp:¤ <CR> ]], desc = '4' },
		},
		{ '<space>wls', ':set et <CR>',   desc = 'Use spaces' },
		{ '<space>wlt', ':set noet <CR>', desc = 'Use tabs' },
		{
			group = 'Width of indentation',
			{ '<space>wwd',  ':set ts=3 sts=3 sw=3  <CR>', desc = 'Default' },
			{ '<space>,ww1', ':set ts=1 sts=1 sw=1 <CR>',  desc = '1' },
			{ '<space>,ww2', ':set ts=2 sts=2 sw=2 <CR>',  desc = '2' },
			{ '<space>,ww3', ':set ts=3 sts=3 sw=3 <CR>',  desc = '3' },
			{ '<space>,ww4', ':set ts=4 sts=4 sw=4 <CR>',  desc = '4' },
			{ '<space>,ww8', ':set ts=8 sts=8 sw=8 <CR>',  desc = '8' },
		},
	}
}
