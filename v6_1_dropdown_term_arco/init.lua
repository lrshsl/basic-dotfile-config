vim = vim


-- TODO: 
--> Store settings! (local? Session?)
--> Undotree
--> Harpoon
--> Telescope themes?
--> Oil?
--> Vista?
--> get good with vim-surround

-- Required before plugins
vim.g.mapleader = " "

Nmap = function(key, command) vim.keymap.set('n', key, command, { noremap = true, silent = true }) end
Vmap = function(key, command) vim.keymap.set('v', key, command, { noremap = true, silent = true }) end
Imap = function(key, command) vim.keymap.set('i', key, command, { noremap = true, silent = true }) end

require 'plugins'
require 'mappings'

require 'settings'

vim.cmd[[
if exists('g:neovide')
	lua require 'neovide'
endif
]]

