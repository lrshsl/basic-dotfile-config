vim.cmd([[

set encoding=utf-8
set exrc

filetype plugin indent on
syntax enable


" Appearance "
set guifont=Source\ Code\ Pro\ Light:h7.5
set guicursor=n-v-c-i:block


" Colors "
set termguicolors
let g:sonokai_transparent_background = 1
colorscheme sonokai  " AFTER settings


" Script to toggle transparent bg "
"let g:bg_transparent = 1
"hi Normal guibg=NONE ctermbg=NONE

"function! Toggle_transparent_background()
"    if g:bg_transparent == 1
"        let g:bg_transparent = 0
"        hi Normal guibg=#111111 ctermbg=black
"    else
"        let g:bg_transparent = 1
"        hi Normal guibg=NONE ctermbg=NONE
"    endif
"endfunction
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



" Tabs vs Spaces "
set ts=4 sts=4 sw=4

set foldmethod=marker
set listchars=tab:-->,trail:.,nbsp:×

augroup ME
    autocmd!

    autocmd BufRead,BufWrite,BufNewFile Makefile :setlocal et!
    autocmd BufRead,BufWrite,BufNewFile Makefile :setlocal list listchars+=leadmultispace:---|
    autocmd BufRead,BufWrite,BufNewFile Makefile :echom "Makefile recognised. Now using tabs for indent"

    autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.hh,*.hpp  :setlocal ts=2 sts=2 sw=2 et
    autocmd BufNewFile,BufRead *.py,*.rs                 :setlocal ts=4 sts=4 sw=4 et!
augroup END



]])
