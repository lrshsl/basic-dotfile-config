
require("colors")

vim.cmd [[

set ts=4 sts=4 sw=4 et

set relativenumber
set number

set nowrap

"set foldenable
"set foldmethod=indent

set statusline+=\{…\}%3{codeium#GetStatusString()}

set listchars=tab:▸\ ,eol:¬

]]
