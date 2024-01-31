vim = vim

-- Required before plugins
vim.g.mapleader = " "

Nmap = function(key, command) vim.keymap.set('n', key, command) end
Imap = function(key, command) vim.keymap.set('i', key, command) end

require 'plugins'
require 'mappings'

require 'settings'

vim.cmd[[
if exists('g:neovide')
	lua require 'neovide'
endif
]]

