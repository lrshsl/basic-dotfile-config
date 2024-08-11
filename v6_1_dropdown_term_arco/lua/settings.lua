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
	{ '<space>,l', ':Limelight!!<CR>',  desc = 'Limelight', silent = true, },
	{ '<space>,g', ':Goyo 90%x90%<CR>', desc = 'Goyo', silent = true, },
	{ '<space>,G', ':Goyo<CR>',         desc = 'Goyo (deactivate)', silent = true, },
	{ '<space>,n', ToggleNumbers,       desc = 'Toggle line numbers', silent = true, },
	{
		group = 'Transparency',
		{ '<space>,bb',  ToggleTransparentBg,          desc = 'Toggle transparency', silent = true, },
		{ '<space>,bt`', BgSetTransparencyCurry(0),    desc = '0', silent = true, },
		{ '<space>,bt1', BgSetTransparencyCurry(0.03), desc = '1', silent = true, },
		{ '<space>,bt2', BgSetTransparencyCurry(0.05), desc = '2', silent = true, },
		{ '<space>,bt3', BgSetTransparencyCurry(0.08), desc = '3', silent = true, },
		{ '<space>,bt4', BgSetTransparencyCurry(0.15), desc = '4', silent = true, },
		{ '<space>,bt5', BgSetTransparencyCurry(0.2),  desc = '5', silent = true, },
		{ '<space>,bt6', BgSetTransparencyCurry(0.3),  desc = '6', silent = true, },
		{ '<space>,bt7', BgSetTransparencyCurry(0.5),  desc = '7', silent = true, },
		{ '<space>,bt8', BgSetTransparencyCurry(0.75), desc = '8', silent = true, },
		{ '<space>,bt9', BgSetTransparencyCurry(0.9),  desc = '9', silent = true, },
		{ '<space>,bt0', BgSetTransparencyCurry(1.0),  desc = '10', silent = true, },
	},
	{
		group = 'Font',
		{ '<space>,f`', SetFontSizeCurry(6),  desc = '6', silent = true, },
		{ '<space>,f1', SetFontSizeCurry(7),  desc = '7', silent = true, },
		{ '<space>,f2', SetFontSizeCurry(8),  desc = '8', silent = true, },
		{ '<space>,f3', SetFontSizeCurry(9),  desc = '9', silent = true, },
		{ '<space>,f4', SetFontSizeCurry(10), desc = '10', silent = true, },
		{ '<space>,f5', SetFontSizeCurry(11), desc = '11', silent = true, },
		{ '<space>,f6', SetFontSizeCurry(12), desc = '12', silent = true, },
		{ '<space>,f7', SetFontSizeCurry(13), desc = '13', silent = true, },
		{ '<space>,f8', SetFontSizeCurry(16), desc = '16', silent = true, },
		{ '<space>,f9', SetFontSizeCurry(20), desc = '20', silent = true, },
		{ '<space>,f0', SetFontSizeCurry(30), desc = '30', silent = true, },
	},
	{
		group = 'Whitespace',
		{
			group = 'List',
			{ '<space>,wll', ':set list!<CR>',                                                      desc = 'Toggle', silent = true, },
			{ '<space>,wl2', [[ :set listchars=tab:-->,trail:~,leadmultispace:·\|,nbsp:¤ <CR> ]],   desc = '2', silent = true, },
			{ '<space>,wl3', [[ :set listchars=tab:-->,trail:~,leadmultispace:··\|,nbsp:¤ <CR> ]],  desc = '3', silent = true, },
			{ '<space>,wl4', [[ :set listchars=tab:-->,trail:~,leadmultispace:···\|,nbsp:¤ <CR> ]], desc = '4', silent = true, },
		},
		{ '<space>,wls', ':set et <CR>',   desc = 'Use spaces', silent = true, },
		{ '<space>,wlt', ':set noet <CR>', desc = 'Use tabs', silent = true, },
		{
			group = 'Width of indentation',
			{ '<space>,wwd',  ':set ts=3 sts=3 sw=3  <CR>', desc = 'Default', silent = true, },
			{ '<space>,ww1', ':set ts=1 sts=1 sw=1 <CR>',  desc = '1', silent = true, },
			{ '<space>,ww2', ':set ts=2 sts=2 sw=2 <CR>',  desc = '2', silent = true, },
			{ '<space>,ww3', ':set ts=3 sts=3 sw=3 <CR>',  desc = '3', silent = true, },
			{ '<space>,ww4', ':set ts=4 sts=4 sw=4 <CR>',  desc = '4', silent = true, },
			{ '<space>,ww8', ':set ts=8 sts=8 sw=8 <CR>',  desc = '8', silent = true, },
		},
	}
}
