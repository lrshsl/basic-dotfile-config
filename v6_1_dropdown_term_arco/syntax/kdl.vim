" kdl syntax highlighting
" author: lrshsl

if v:version < 600
	syntax clear
elseif exists('b:current_syntax')
	finish
endif

syn keyword		Keyword					bind

syn region		String					start='"' skip='\\"' end='"'

syn match		Comment					"//.*"


let b:current_syntax="kdl"

" vim: noet sw=3 sts=3 ts=3
