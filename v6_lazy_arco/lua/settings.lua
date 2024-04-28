vim.cmd [[
set encoding=utf-8
set exrc

filetype plugin indent on
syntax enable


" Appearance "
set guifont=Source\ Code\ Pro\ Light:h7.5

"set colorcolumn=80 

" Colors "
set termguicolors
let g:sonokai_transparent_background = 1
colorscheme sonokai  " AFTER other settings

set nowrap

" Tabs vs Spaces "
set et! ts=4 sts=4 sw=4

set foldmethod=marker
set listchars=tab:-->,trail:~

augroup TAB_VS_SPACES_AUGROUP
	autocmd!

    autocmd BufRead,BufWrite,BufNewFile Makefile :setlocal et!
    autocmd BufRead,BufWrite,BufNewFile Makefile :setlocal list listchars+=leadmultispace:.
    autocmd BufRead,BufWrite,BufNewFile Makefile :echom "Makefile recognised. Now using tabs for indent"

    autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.hh,*.hpp :setlocal et ts=2 sts=2 sw=2

    autocmd BufNewFile,BufRead *.nim :setlocal et ts=2 sts=2 sw=2
augroup END


" Script to toggle transparent bg "
function! Toggle_transparent_background()
    if g:sonokai_transparent_background == 1
        let g:sonokai_transparent_background = 0
        colorscheme sonokai
        hi Normal guibg=#111111 ctermbg=black
    else
        let g:sonokai_transparent_background = 1
        colorscheme sonokai
    endif
endfunction

nnoremap <C-x><C-t> :call Toggle_transparent_background()<CR>
]]
