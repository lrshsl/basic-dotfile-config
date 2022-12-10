vim.cmd([[
set encoding=utf-8
set exrc

filetype plugin indent on
syntax enable

set termguicolors

set ts=4 sts=4
set sw=4 et

augroup ME
	autocmd!

    autocmd BufRead,BufWrite,BufNewFile Makefile :setlocal noexpandtab
    autocmd BufRead,BufWrite,BufNewFile Makefile :setlocal list listchars=tab:>~
 
    autocmd BufRead,BufWrite,BufNewFile Makefile :echom "Makefile recognised. Now using tabs for indent"
augroup END
]])
