" Vim indent file
" Language:         Nim
" Maintainer:		lrshsl (gitub.com/lrshsl)
" Based On:	        python.vim by David Bustos <bustos@caltech.edu>
" Last Change:		2024 April 11

" :help ft-vim-indent
" :help ft-vim-syntax
" :help ft-man-plugin

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" Some preliminary settings
setlocal nolisp		" Make sure lisp indenting doesn't supersede us
setlocal autoindent	" indentexpr isn't much help otherwise

setlocal indentexpr=python#GetIndent(v:lnum)
setlocal indentkeys+=<:>,=elif,=except

let b:undo_indent = "setl ai< inde< indk< lisp<"

" Only define the function once.
if exists("*GetPythonIndent")
  finish
endif

let s:end_chars = '[=:]$'
let s:end_words = '(type\|object)'

function GetPythonIndent(lnum)
  let prevline = getline(lnum - 1)
  " if prevline =~ s:end_chars
  "   return shiftwidth()
  " endif
  return GetPythonIndent(lnum)
endfunction

" vim:sw=2

