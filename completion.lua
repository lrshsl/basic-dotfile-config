-- TODO:
---- Fix live grep
---- Jump to line (or get better with `rnu`)
---- Jump to word
---- Harpoon or global marks (tags?)
--- Fix dk dj cases

-- Remember:
--- Cursorcolumn for checking alignment of text

--- Pre init {{{
-- disable netrw in favor of Nvimtree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
--- }}}


---------- Variables ---------

--- Python Interpreter {{{
vim.g.python3_host_prog = "/usr/bin/python3"
--- }}}

--- Lua Aliases {{{
local nmap = function(trigger, action)
   vim.keymap.set('n', trigger, action)
end
local imap = function(trigger, action)
   vim.keymap.set('i', trigger, action)
end
--- }}}


---------- Mappings ----------

--- Ctrl-Remaps {{{
vim.cmd [[
   inoremap <C-BS> <C-w>

	inoremap <C-h> <C-o>B
   inoremap <C-n> <C-o>g<up>
   inoremap <C-e> <C-o>g<down>
   inoremap <C-i> <C-o>E
]]
--- }}}

--- Colemak mappings {{{
vim.cmd [[
" Note: I use gj, gk, g$, g0 etc instead of j, k, $, 0.., which treats wraped lines as normal lines

inoremap tn <esc>


noremap n gj
noremap N 5gj

noremap e gk
noremap E 5gk

noremap k e
noremap K E

noremap i <right>
noremap I g$

noremap H g^

noremap l i
noremap L g^i

noremap A g$a

noremap m n
noremap M N


" Keep those combinations
nnoremap dn dj
nnoremap de dk

nnoremap yn yj
nnoremap ye yk

nnoremap cn cj
nnoremap ce ck
]]
--- }}}

--- Other Shortcuts {{{
vim.keymap.set('i', ':w<CR>', '<esc>:w<CR>')
vim.keymap.set('i', ';w<CR>', '<esc>:w<CR>')

--- Launching, Execute Commands ---
--- Change Settings {{{
vim.cmd[[
" Spell
nnoremap <space>,s :setlocal spell!<CR>

" Wrap
nnoremap <space>,w :setlocal wrap<CR>
nnoremap <space>,W :setlocal wrap!<CR>

" Codeium
nnoremap <space>,c :CodeiumEnable<CR>
nnoremap <space>,C :CodeiumDisable<CR>

" Line Numbers
nnoremap <space>,l :setlocal nu rnu<CR>
nnoremap <space>,L :setlocal nu! rnu!<CR>
]]
--- }}}
--- Appearance {{{
function Setbg(mode)
   if mode == 'black' then
      vim.cmd 'hi Normal guibg=#000000 ctermbg=0'
      vim.cmd 'hi NonText guibg=#000000 ctermbg=0'
   elseif mode == 'dark' then
      vim.cmd 'hi Normal guibg=#000010 ctermbg=0'
      vim.cmd 'hi NonText guibg=#000010 ctermbg=0'
   elseif mode == 'light' then
      vim.cmd 'hi Normal guibg=#0a101a ctermbg=6'
      vim.cmd 'hi NonText guibg=#0a101a ctermbg=6'
   elseif mode == 'normal' then
      vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
      vim.cmd 'hi NonText guibg=NONE ctermbg=NONE'
   end
end
vim.keymap.set('n', '<space>,bb', function() Setbg('black') end)
vim.keymap.set('n', '<space>,bd', function() Setbg('dark') end)
vim.keymap.set('n', '<space>,bn', function() Setbg('normal') end)

vim.cmd 'colorscheme monokai'
--- }}}
--- File Navigation {{{
vim.cmd [[
nnoremap <silent> <space>o  :NvimTreeToggle<CR>
nnoremap <silent> <space>fq :Oil<CR>

" FZF's `:Files` but respects .gitignore
" And `Telescope git_files` gives an error if not in a git repo
nnoremap <silent> <space>ff	:call fzf#run(fzf#wrap({'source': 'rg --files'}))<CR>

"nnoremap <silent> <space>fq	:Lexplore 28<CR>
"nnoremap <silent> <space>fl	:Lines<CR>                    " Not installed
nnoremap <silent> <space>fg	:Telescope grep_string<CR>    " Sometimes has problems finding comments?
"nnoremap <silent> <space>fg	:call fzf#run(fzf#wrap({'source': 'rg .'}))<CR>
nnoremap <silent> <space>fb	:Telescope buffers<CR>
]]
--- }}}
--- Code Navigation, Zen Mode etc {{{
vim.cmd [[
nnoremap <silent> <space>;S	:%s/\<<C-r><C-w>\>//gc<left><left><left>
nnoremap <silent> <space>;s	:%s//gc<left><left><left>
vnoremap <silent> <space>;s	:s//gc<left><left><left>
nnoremap <silent> <space>;v	:Vista<CR>
nnoremap <silent> <space>;V	:Vista!<CR>

let g:limelight_conceal_ctermfg = 240
nnoremap <silent> <space>;al	:Limelight!!<CR>
nnoremap <silent> <space>;ag	:Goyo 40%<CR>

" Writing mode
nnoremap <silent> <space>;w	:Limelight!!<CR> :Goyo 40%<CR
]]
--- }}}
--- Spell checking {{{
vim.cmd [[
set spelllang=en_us,de

" Change Last Spelling Mistake
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
nnoremap <C-l> [s1z=
]]
--- }}}
--- Windows, buffers && co {{{
vim.cmd [[
nnoremap <silent> <C-space> <C-z>

nnoremap <silent> <space>q :q<CR>
nnoremap <silent> <space>w :w<CR>

" Wincmd mappings
nnoremap <silent> <space>h :wincmd h<CR>
nnoremap <silent> <space>n :wincmd j<CR>
nnoremap <silent> <space>e :wincmd k<CR>
nnoremap <silent> <space>i :wincmd l<CR>


" Resizing
noremap <silent> <C-left> :vertical res +5<CR>
noremap <silent> <C-down> :res +5<CR>
noremap <silent> <C-up>   :res -5<CR>
noremap <silent> <C-right> :vertical res -5<CR>


" Buffers
"<space>fb -> :Buffers
noremap <silent> <C-e> :bn<CR>
noremap <silent> <C-n> :bp<CR>
nnoremap <silent> <space>bk :bdelete<CR>


" Open header/source file
nnoremap gh :FSSplitRight<CR>
nnoremap gH :FSHere<CR>
]]
--- }}}
--- Code Actions {{{
nmap('<space>]d', vim.diagnostic.goto_next)		--- Lsp Diagnostic
nmap('<space>[d', vim.diagnostic.goto_prev)		--- Lsp Diagnostic
nmap('<space>ld', vim.diagnostic.open_float)		--- Lsp Diagnostic
nmap('<space>lh', vim.lsp.buf.hover)				--- Lsp Hover
nmap('<space>ls', vim.lsp.buf.signature_help)	--- Lsp Signature
nmap('<space>la', vim.lsp.buf.code_action)		--- Lsp Code Action
nmap('<space>lr', vim.lsp.buf.rename)           --- Lsp Rename
imap('<C-a>', vim.lsp.buf.signature_help)
nmap('<space>;F', function() vim.cmd':call LspZeroFormat()' end)
--- gd		Go Definition
--- gD		Go Declaration
--- gi		Go Implementation
--- gr		Go References
--- }}}
--- Div {{{
vim.cmd[[
" Move lines
vnoremap <silent> <C-e> :m '<-2<CR>gv=gv		" move up
vnoremap <silent> <C-n> :m '>+1<CR>gv=gv		" move down

]]
--- }}}

--- Language Specific ---
--- Compile / Run Commands {{{
vim.cmd [[
nnoremap <space>rs :!
augroup LRS_RUN_CMDS
   au!
   au BufEnter,BufWrite *.py              nnoremap <space>rr      :!python
   au BufEnter,BufWrite *.py              nnoremap <space>rf      :!python %
   au BufEnter,BufWrite *.py              nnoremap <space>rm      :!python main.py
              
   au BufEnter,BufWrite *.rs,Cargo.toml   nnoremap <space>rr      :!cargo r
   au BufEnter,BufWrite *.rs,Cargo.toml   nnoremap <space>rR      :!cargo r --release
   au BufEnter,BufWrite *.rs,Cargo.toml   nnoremap <space>rb      :!cargo build
   au BufEnter,BufWrite *.rs,Cargo.toml   nnoremap <space>rc      :!cargo check
              
   au BufEnter,BufWrite *.zig             nnoremap <space>rr      :!zig build
              
   " C        
   au BufEnter,BufWrite *.c,*.h,Makefile  nnoremap <space>rr      :!make run     " Release
   au BufEnter,BufWrite *.c,*.h,Makefile  nnoremap <space>rbm     :!make         " Make Build
   au BufEnter,BufWrite *.c,*.h,Makefile  nnoremap <space>rdm     :!make dbg     " Make debug
   au BufEnter,BufWrite *.c,*.h,Makefile  nnoremap <space>rcm     :!make clean   " Make clean
              
   au BufEnter,BufWrite *.c,*.h,Makefile  nnoremap <space>rf      :!gcc -o c.out --std=c99 -Wall -Wextra -pedantic -g -Og % && ./c.out
   au BufEnter,BufWrite *.c,*.h,Makefile  nnoremap <space>rdf     :!gcc -o c.out --std=c99 -Wall -Wextra -pedantic -g -Og %
   au BufEnter,BufWrite *.c,*.h,Makefile  nnoremap <space>rrf     :!gcc -o c.out --std=c99 -Wall -Wextra -pedantic -O2 %
   au BufEnter,BufWrite *.c,*.h,Makefile  nnoremap <space>rrf     :!gcc -o c.out --std=c99 -Wall -Wextra -pedantic -O2 % && ./c.out

   au BufEnter,BufWrite *.md,*.tex        nnoremap <space>rb      :!pandoc % -o out.pdf
augroup END
]]
--- }}}

--- }}}


---------- Settings ----------

--- General Settings {{{
vim.cmd [[
set foldenable foldmethod=marker
filetype plugin indent on
syntax enable

set scrolloff=10
set wrap linebreak
" linebreak: wrap at word boundaries
set cursorline culopt=number,screenline
]]
--- }}}

--- Indentation {{{
vim.cmd [[
set et! ts=3 sts=3 sw=3
"set smartindent
augroup USER_INDENT
	au!
	au BufNewFile,BufRead *.c,*.h					:setlocal et  sw=2 ts=2 sts=2
	au BufNewFile,BufRead *.l,*.y					:setlocal et  sw=2 ts=2 sts=2
	au BufNewFile,BufRead *.cpp,*.hh,*.hpp		:setlocal et  sw=2 ts=2 sts=2
	au BufNewFile,BufRead Makefile				:setlocal et! sw=3 ts=3 sts=3
augroup END
]]
--- }}}

--- Latex {{{
vim.cmd [[
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0

set conceallevel=1
let g:tex_conceal='abdmg'
hi Conceal ctermbg=none

" Alternative implementation under `:helpgrep Eatchar`
func! Eatchar()
	let c = getchar(0)
	return ''
endfunc


augroup CUSTOM_LATEX
   au!
   au BufEnter *.tex imap ;in \lstinline{}<left><C-R>=Eatchar()<CR>
   au BufEnter *.tex imap ;sec \section{}<left><C-R>=Eatchar()<CR>
   au BufEnter *.tex imap ;ssec \subsection{}<left><C-R>=Eatchar()<CR>
   au BufEnter *.tex imap ;enum \begin{enumerate}[a)]<C-R>=Eatchar()<CR>
   au BufEnter *.tex iabbr itm \item
   au BufEnter *.tex iabbr ``` \begin{lstlisting}<CR><C-r>=Eatchar()<CR>
   au BufEnter *.tex imap ` \lstinline{}<left>
augroup END

imap ;ae ä
imap ;oe ö
imap ;ue ü
imap ;Ae Ä
imap ;Oe Ö
imap ;Ue Ü
]] --- }}}


---------- Plugins -----------

--- Packer {{{
vim.cmd.packadd 'packer.nvim'

local startup_fn = require 'packer'.startup(function(use)
   --- Packer
   use 'wbthomason/packer.nvim'

   --- File Navigation {{{
   use {
      "theprimeagen/harpoon",
      branch = "harpoon2",
      requires = { {"nvim-lua/plenary.nvim"} },
   }
   use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      requires = { { 'nvim-lua/plenary.nvim' } }
   }
   use {
      'nvim-tree/nvim-tree.lua',
      requires = {
         'nvim-tree/nvim-web-devicons',
      }
   }
   use {
      'stevearc/oil.nvim',
      config = function() require('oil').setup() end,
      requires = {
         'nvim-tree/nvim-web-devicons',
      }
   }
   --- use 'fzf'
   --- }}}

   --- Appearance {{{
   use 'sainnhe/sonokai'
   use 'tanvirtin/monokai.nvim'
   use 'ray-x/aurora'
   use 'junegunn/goyo.vim'
   use 'junegunn/limelight.vim'
   --- }}}

   --- IDE Stuff {{{
   -- use "mbbill/undotree"
   use 'tpope/vim-commentary'
   -- use 'm4xshen/autoclose.nvim'
   use 'KeitaNakamura/tex-conceal.vim'
   use 'liuchengxu/vista.vim'

	use 'Exafunction/codeium.vim'

   use 'lervag/vimtex'

   --- }}}

   --- LSP stuff {{{
   --- Treesitter {{{
   use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
         local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
         ts_update()
      end
   }
   use "nvim-treesitter/nvim-treesitter-context"
   --- }}}
   --- Trouble {{{
   use {
      "folke/trouble.nvim",
      config = function()
         require("trouble").setup {
            icons = true,
            -- configuration
         }
      end,
      requires = {
         { 'nvim-tree/nvim-web-devicons' },
      }
   }
   --- }}}
   -- use "tpope/vim-fugitive"

   --- Lsp Zero {{{
   use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      requires = {
         -- LSP Support
         { 'neovim/nvim-lspconfig' },
         { 'williamboman/mason.nvim' },
         { 'williamboman/mason-lspconfig.nvim' },

         -- Autocompletion
         { 'hrsh7th/nvim-cmp' },
         { 'hrsh7th/cmp-buffer' },
         { 'hrsh7th/cmp-path' },
         { 'saadparwaiz1/cmp_luasnip' },
         { 'hrsh7th/cmp-nvim-lsp' },
         { 'hrsh7th/cmp-nvim-lua' },

         -- Snippets
         { 'SirVer/ultisnips' },
         {
            'quangnguyen30192/cmp-nvim-ultisnips',
            config = function()
               -- optional call to setup (see customization section)
               require("cmp_nvim_ultisnips").setup {}
            end,
            -- Enable filetype detection based on treesitter
            requires = { "nvim-treesitter/nvim-treesitter" },
         },
         { 'honza/vim-snippets' },
      }
   }
   --- }}}

   -- use "folke/zen-mode.nvim"
   -- use "laytan/cloak.nvim"
   --- }}}
end)
--- }}}

--- Package Config {{{

--- Lsp Zero {{{
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_, bufnr)
   -- see :help lsp-zero-keybindings
   lsp.default_keymaps({ buffer = bufnr })
end)

-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
--- }}}
--- Cmp Setup, AFTER Lsp-zero {{{
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')

vim.cmd [[ let g:UltiSnipsSnippetDirectories=['UltiSnips', 'own_snippets'] ]]

cmp.setup({
   
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },

   --- Mappings {{{
   mapping = {
      -- `Enter` key to confirm completion
      ['<tab>'] = cmp.mapping.confirm({ select = true }),
      -- ['<C-f>'] = cmp.mapping(
      --    function(fallback)
      --       cmp_ultisnips_mappings.compose { 'expand' } (fallback)
      --    end,
      --    { 'i', 's', --[[ 'c' (to enable the mapping in command mode) ]] }),
      ['<down>'] = cmp.mapping(
         function(fallback)
            cmp_ultisnips_mappings.compose { 'jump_forwards', 'select_next_item' } (fallback)
         end,
         { 'i', 's', --[[ 'c' (to enable the mapping in command mode) ]] }),
      ['<up>'] = cmp.mapping(
         function(fallback)
            cmp_ultisnips_mappings.compose { 'jump_backwards', 'select_prev_item' } (fallback)
         end,
         { 'i', 's', --[[ 'c' (to enable the mapping in command mode) ]] }),

      -- Ctrl+Space to trigger completion menu
      ['<C-Space>'] = cmp.mapping.complete(),
      -- ['<C-f>'] = cmp.mapping.complete(),

      -- Navigate between snippet placeholder
      ['<C-f>'] = cmp_action.luasnip_jump_forward(),
      ['<C-b>'] = cmp_action.luasnip_jump_backward(),
   },
   --- }}}
   --- Sources {{{
   sources = {
      { name = 'nvim_lsp' },
      { name = 'cmp-nvim-lsp' },
      { name = 'path' },
      { name = 'ultisnips' },
      { name = 'buffer' },
   }
   --- }}}
})

--- }}}
--- Codeium {{{
vim.cmd[[
let g:codeium_no_map_tab = v:true
imap <script><silent><nowait><expr> <C-y> codeium#Accept()

let g:codeium_filetypes = {
	\ 'markdown': v:false,
	\ }
]]
--- }}}
--- Oil {{{
require("oil").setup({
  default_file_explorer = true,
  columns = { "icon", },
  -- Skip the confirmation popup for simple operations
  skip_confirm_for_simple_edits = false,
  -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
  delete_to_trash = false,
  -- Change this to customize the command used when deleting to trash
  trash_command = "trash-put",
  -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
  prompt_save_on_select_new_entry = true,
  -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
  -- Additionally, if it is a string that matches "actions.<name>",
  -- it will use the mapping at require("oil.actions").<name>
  -- Set to `false` to remove a keymap
  -- See :help oil-actions for a list of all available actions
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
  },
  use_default_keymaps = true,
  view_options = {
    show_hidden = false,
    -- This function defines what is considered a "hidden" file
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    -- This function defines what will never be shown, even when `show_hidden` is set
    is_always_hidden = function(name, bufnr)
      return name == ".git"
    end,
    sort = {
      -- sort order can be "asc" or "desc"
      -- see :help oil-columns to see which columns are sortable
      { "type", "asc" },
      { "name", "asc" },
    },
  },
  -- Configuration for the actions floating preview window
  preview = {
    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a single value or a list of mixed integer/float types.
    -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
    max_width = 0.9,
    -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
    min_width = { 40, 0.4 },
    -- optionally define an integer/float for the exact width of the preview window
    width = nil,
    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a single value or a list of mixed integer/float types.
    -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
    max_height = 0.9,
    -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
    min_height = { 5, 0.1 },
    -- optionally define an integer/float for the exact height of the preview window
    height = nil,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
  },
  -- Configuration for the floating progress window
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
})
--- }}}
--- Nvim Tree {{{
local nvim_tree_on_attach = function(bufnr)
	local api = require "nvim-tree.api"
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
	 vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
	 vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              opts('Info'))
	 vim.keymap.set('n', 'R', api.fs.rename_sub,									opts('Rename: Omit Filename'))
	 vim.keymap.set('n', '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
	 vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
	 vim.keymap.set('n', '<CR>',  api.node.open.edit,                    opts('Open'))
	 vim.keymap.set('n', '<Tab>', api.node.open.preview,                 opts('Open Preview'))
	 vim.keymap.set('n', '>',     api.node.navigate.sibling.next,        opts('Next Sibling'))
	 vim.keymap.set('n', '<',     api.node.navigate.sibling.prev,        opts('Previous Sibling'))
	 vim.keymap.set('n', '!',     api.node.run.cmd,                      opts('Run Command'))
	 vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        opts('Up'))
	 vim.keymap.set('n', 'H',     api.tree.change_root_to_parent,        opts('Up'))
	 vim.keymap.set('n', 'a',     api.fs.create,                         opts('Create'))
	 vim.keymap.set('n', 'c',     api.fs.copy.node,                      opts('Copy'))
	 vim.keymap.set('n', 'd',     api.fs.remove,                         opts('Delete'))
	 vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
	 -- vim.keymap.set('n', 'r',     api.fs.rename_basename,                opts('Rename: Basename'))
	 vim.keymap.set('n', ']d',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
	 vim.keymap.set('n', '[d',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
	 vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  opts('Help'))
	 vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
	 vim.keymap.set('n', 'gh',     api.tree.toggle_hidden_filter,         opts('Toggle Filter: Dotfiles'))
	 vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
	 vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
	 vim.keymap.set('n', 'p',     api.fs.paste,                          opts('Paste'))
	 vim.keymap.set('n', 'P',     api.node.navigate.parent,              opts('Parent Directory'))
	 vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))
	 vim.keymap.set('n', 'r',     api.fs.rename,                         opts('Rename'))
	 vim.keymap.set('n', '<C-r>', api.tree.reload,                       opts('Refresh'))
	 vim.keymap.set('n', 's',     api.node.run.system,                   opts('Run System'))
	 vim.keymap.set('n', 'W',     api.tree.collapse_all,                 opts('Collapse'))
	 vim.keymap.set('n', 'y',     api.fs.copy.filename,                  opts('Copy Name'))
	 vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
	 vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
	 vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
 end

require("nvim-tree").setup({
	on_attach = nvim_tree_on_attach,
	sort_by = "case_sensitive",
	view = {
		width = 30,
	},
	filters = {
		dotfiles = false,
	},
})
--- }}}
-- --- Harpoon {{{
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<space>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<bs>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<bs>n", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<bs>e", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<bs>i", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<bs>o", function() harpoon:list():select(4) end)
-- --- }}}
--- Other {{{
-- require("autoclose").setup()
vim.cmd[[
imap ;nn neural network
]]
--- }}}

--- }}}


return startup_fn
