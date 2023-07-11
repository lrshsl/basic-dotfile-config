vim.cmd([[


" colorscheme
"let base16colorspace=256
"colorscheme base16-gruvbox-dark-hard
"colorscheme base16-black-metal-bathory
set background=dark
" True Color Support if it's avaiable in terminal
if has("termguicolors")
    set termguicolors
endif
if has("gui_running")
  set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:blocks
endif

]])

require("plugins")
require("settings")
require("mappings")
