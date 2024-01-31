return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.5',
	dependencies = { 'nvim-lua/plenary.nvim' },
	lazy = false,
	keys = {
		{ '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
		{ '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
		{ '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
		{ '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help tags' },
	},
}
