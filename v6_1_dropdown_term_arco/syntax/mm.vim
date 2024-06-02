" Markman syntax "


syn keyword markmanKeyword df
syn keyword markmanTitle '#+.*'

syn region markdownH1 matchgroup=markdownH1Delimiter start=" \{,3}#\s"      end="#*\s*$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained
syn region markdownH2 matchgroup=markdownH2Delimiter start=" \{,3}##\s"     end="#*\s*$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained
syn region markdownH3 matchgroup=markdownH3Delimiter start=" \{,3}###\s"    end="#*\s*$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained
syn region markdownH4 matchgroup=markdownH4Delimiter start=" \{,3}####\s"   end="#*\s*$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained
syn region markdownH5 matchgroup=markdownH5Delimiter start=" \{,3}#####\s"  end="#*\s*$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained
syn region markdownH6 matchgroup=markdownH6Delimiter start=" \{,3}######\s" end="#*\s*$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained

syn match markdownBlockquote ">\%(\s\|$\)" contained nextgroup=@markdownBlock

syn region markdownCodeBlock start="^\n\( \{4,}\|\t\)" end="^\ze \{,3}\S.*$" keepend

" TODO: real nesting
syn match markdownListMarker "\%(\t\| \{0,4\}\)[-*+]\%(\s\+\S\)\@=" contained
syn match markdownOrderedListMarker "\%(\t\| \{0,4}\)\<\d\+\.\%(\s\+\S\)\@=" contained

syn match markdownRule "\* *\* *\*[ *]*$" contained
syn match markdownRule "- *- *-[ -]*$" contained

syn match markdownLineBreak " \{2,\}$"

syn region markdownIdDeclaration matchgroup=markdownLinkDelimiter start="^ \{0,3\}!\=\[" end="\]:" oneline keepend nextgroup=markdownUrl skipwhite
syn match markdownUrl "\S\+" nextgroup=markdownUrlTitle skipwhite contained
syn region markdownUrl matchgroup=markdownUrlDelimiter start="<" end=">" oneline keepend nextgroup=markdownUrlTitle skipwhite contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+"+ end=+"+ keepend contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+'+ end=+'+ keepend contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+(+ end=+)+ keepend contained

syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\_[^][]*\%(\[\_[^][]*\]\_[^][]*\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained
syn region markdownId matchgroup=markdownIdDelimiter start="\[" end="\]" keepend contained
syn region markdownAutomaticLink matchgroup=markdownUrlDelimiter start="<\%(\w\+:\|[[:alnum:]_+-]\+@\)\@=" end=">" keepend oneline

let s:concealends = ''
if has('conceal') && get(g:, 'markdown_syntax_conceal', 1) == 1
  let s:concealends = ' concealends'
endif
exe 'syn region markdownItalic matchgroup=markdownItalicDelimiter start="\*\S\@=" end="\S\@<=\*\|^$" skip="\\\*" contains=markdownLineStart,@Spell' . s:concealends
exe 'syn region markdownItalic matchgroup=markdownItalicDelimiter start="\w\@<!_\S\@=" end="\S\@<=_\w\@!\|^$" skip="\\_" contains=markdownLineStart,@Spell' . s:concealends
exe 'syn region markdownBold matchgroup=markdownBoldDelimiter start="\*\*\S\@=" end="\S\@<=\*\*\|^$" skip="\\\*" contains=markdownLineStart,markdownItalic,@Spell' . s:concealends
exe 'syn region markdownBold matchgroup=markdownBoldDelimiter start="\w\@<!__\S\@=" end="\S\@<=__\w\@!\|^$" skip="\\_" contains=markdownLineStart,markdownItalic,@Spell' . s:concealends
exe 'syn region markdownBoldItalic matchgroup=markdownBoldItalicDelimiter start="\*\*\*\S\@=" end="\S\@<=\*\*\*\|^$" skip="\\\*" contains=markdownLineStart,@Spell' . s:concealends
exe 'syn region markdownBoldItalic matchgroup=markdownBoldItalicDelimiter start="\w\@<!___\S\@=" end="\S\@<=___\w\@!\|^$" skip="\\_" contains=markdownLineStart,@Spell' . s:concealends
exe 'syn region markdownStrike matchgroup=markdownStrikeDelimiter start="\~\~\S\@=" end="\S\@<=\~\~\|^$" contains=markdownLineStart,@Spell' . s:concealends

syn region markdownCode matchgroup=markdownCodeDelimiter start="`" end="`" keepend contains=markdownLineStart
syn region markdownCode matchgroup=markdownCodeDelimiter start="`` \=" end=" \=``" keepend contains=markdownLineStart
syn region markdownCodeBlock matchgroup=markdownCodeDelimiter start="^\s*\z(`\{3,\}\).*$" end="^\s*\z1\ze\s*$" keepend
syn region markdownCodeBlock matchgroup=markdownCodeDelimiter start="^\s*\z(\~\{3,\}\).*$" end="^\s*\z1\ze\s*$" keepend

hi def link markmanKeyword Keyword
