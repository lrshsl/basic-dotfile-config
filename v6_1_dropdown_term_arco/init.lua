vim = vim


-- TODO:
--> Store settings! (local? Session?)
--> fix noice
--> Undotree
--> Harpoon
--> Telescope themes?
--> Vista?
--> get good with vim-surround
--
--> ditch nvim-cmp for <C-x><C-o> omnifunc?

-- Required before plugins
vim.g.mapleader = " "

Nmap = function(key, command) vim.keymap.set('n', key, command, { noremap = true, silent = true }) end
Vmap = function(key, command) vim.keymap.set('v', key, command, { noremap = true, silent = true }) end
Imap = function(key, command) vim.keymap.set('i', key, command, { noremap = true, silent = true }) end
Tmap = function(key, command) vim.keymap.set('t', key, command, { noremap = true, silent = true }) end

require 'plugins'
require 'mappings'

require 'settings'

vim.cmd [[
if exists('g:neovide')
	lua require 'neovide'
endif

iunmap <tab>
]]
