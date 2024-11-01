 
if v:version < 600
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Some keywords
syn keyword   exasConditional    fn                      nextgroup=exasFnName
syn keyword   exasLabel          const mut or pub rw Rw rW RW
syn match     exasReg            "r[0-9][0-9]"
syn keyword   exasBasicType      Int Real Char Bool String
"syn keyword exasSpecialType World ProcId Void Files File
syn keyword   exasModuleSystem   mod data
syn keyword   exasTypeClass      struct enum impl
syn match     exasFnName         "[a-zA-Z_][a-zA-Z0-9_]*" contained display

" To do some Denotation Highlighting
syn keyword   exasBoolDenot      true false
syn region    exasStringDenot    start=+"+ skip=+\(\(\\\\\)\+\|\\"\)+ end=+"+ display
syn match     exasCharDenot      "'\(\\\\\|\\'\|[^'\\]\)\+'" display
syn match     exasIntegerDenot   "[\~+-]\?\<\(\d\+\|0[0-7]\+\|0x[0-9A-Fa-f]\+\)\>" display
syn match     exasRealDenot      "[\~+-]\?\d\+\.\d\+\(E[\~+-]\?\d\+\)\?" display

" To highlight the use of lists, tuples and arrays
syn region    exasArray          start="{:" end=":}"      contains=ALL
syn match     exasTuple          "([^=]*,[^=]*)"          contains=ALL

" To do some Comment Highlighting
syn region    exasCommentDel     start="|"  end="|" skip="[^\n\r|]*"      contains=exasTodo fold
syn region    exasComment        start="|"  end="$"       contains=exasTodo fold
syn region    exasDocDel         start="||" end="||" skip="[^\n\r]*"      contains=exasTodo display
syn region    exasDoc            start="||" end="$"       contains=exasTodo display
syn keyword   exasTodo           TODO FIXME XXX           contained


" Define the default highlighting.
" Only when an item doesn't have highlighting yet

 " Comments
 hi def link exasComment      Comment
 hi def link exasDoc          Comment
 hi def link exasCommentDel   Comment
 hi def link exasDocDel       Comment
 " Constants and denotations
 hi def link exasStringDenot  String
 hi def link exasCharDenot    Character
 hi def link exasIntegerDenot Number
 hi def link exasBoolDenot    Boolean
 hi def link exasRealDenot    Float
 " Identifiers
 hi def link exasFnName       Function
 " Statements
 hi def link exasTypeClass    Keyword
 hi def link exasConditional  Conditional
 hi def link exasLabel        Label
 hi def link exasKeyword      Keyword
 " Generic Preprocessing
 hi def link exasIncludeKeyword  Include
 hi def link exasModuleSystem    PreProc
 " Type
 hi def link exasBasicType    Type
 " Special
 hi def link exasArray        Special
 hi def link exasTuple        Special
 " Error
 " Todo
 hi def link exasTodo         Todo


let b:current_syntax = "exas"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: ts=4
