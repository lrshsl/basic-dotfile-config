 
if v:version < 600
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Some Clean-keywords
syn keyword exasConditional is match
syn keyword exasLabel or pub
syn keyword exasSpecial Start
syn keyword exasKeyword const reg
syn keyword exasBasicType Int Real Char Bool String
syn keyword exasSpecialType World ProcId Void Files File
syn keyword exasModuleSystem module implementation definition system
syn keyword exasTypeClass class instance export

" Import highlighting
syn region exasIncludeRegion start="^\s*\(from\|import\|\s\+\(as\|qualified\)\)" end="\n" contains=exasIncludeKeyword keepend
syn keyword exasIncludeKeyword contained from import as qualified

" To do some Denotation Highlighting
syn keyword exasBoolDenot True False
syn region exasStringDenot start=+"+ skip=+\(\(\\\\\)\+\|\\"\)+ end=+"+ display
syn match exasCharDenot "'\(\\\\\|\\'\|[^'\\]\)\+'" display
syn match exasIntegerDenot "[\~+-]\?\<\(\d\+\|0[0-7]\+\|0x[0-9A-Fa-f]\+\)\>" display
syn match exasRealDenot "[\~+-]\?\d\+\.\d\+\(E[\~+-]\?\d\+\)\?" display

" To highlight the use of lists, tuples and arrays
syn region exasList start="\[" end="\]" contains=ALL
syn region exasRecord start="{" end="}" contains=ALL
syn region exasArray start="{:" end=":}" contains=ALL
syn match exasTuple "([^=]*,[^=]*)" contains=ALL

" To do some Comment Highlighting
syn region exasComment start="/\*"  end="\*/" contains=exasComment,exasTodo fold
syn region exasComment start="//.*" end="$" display contains=exasTodo
syn keyword exasTodo TODO FIXME XXX contained

" Now for some useful type definition recognition
syn match exasFuncTypeDef "\([a-zA-Z].*\|(\=[-~@#$%^?!+*<>\/|&=:]\+)\=\)\s*\(infix[lr]\=\)\=\s*\d\=\s*::.*->.*" contains=exasSpecial,exasBasicType,exasSpecialType,exasKeyword


" Define the default highlighting.
" Only when an item doesn't have highlighting yet

 " Comments
 hi def link exasComment      Comment
 " Constants and denotations
 hi def link exasStringDenot  String
 hi def link exasCharDenot    Character
 hi def link exasIntegerDenot Number
 hi def link exasBoolDenot    Boolean
 hi def link exasRealDenot    Float
 " Identifiers
 " Statements
 hi def link exasTypeClass    Keyword
 hi def link exasConditional  Conditional
 hi def link exasLabel		Label
 hi def link exasKeyword      Keyword
 " Generic Preprocessing
 hi def link exasIncludeKeyword      Include
 hi def link exasModuleSystem PreProc
 " Type
 hi def link exasBasicType    Type
 hi def link exasSpecialType  Type
 hi def link exasFuncTypeDef  Typedef
 " Special
 hi def link exasSpecial      Special
 hi def link exasList			Special
 hi def link exasArray		Special
 hi def link exasRecord		Special
 hi def link exasTuple		Special
 " Error
 " Todo
 hi def link exasTodo         Todo


let b:current_syntax = "exas"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: ts=4
