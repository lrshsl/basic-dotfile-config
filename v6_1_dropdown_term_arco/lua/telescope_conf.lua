return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.5',
	dependencies = {
		'nvim-lua/plenary.nvim',

		-- Extentions
		'nvim-telescope/telescope-ui-select.nvim'
	},
	lazy = false,
	config = function()
		local ts = require 'telescope'
		local ts_themes = require 'telescope.themes'
		ts.setup {
			extentions = {
				["ui-select"] = {
					ts_themes.get_dropdown {}
				}
			}
		}
		ts.load_extension('ui-select')
	end,
}
