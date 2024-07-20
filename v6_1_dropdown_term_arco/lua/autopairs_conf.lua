return {
	'windwp/nvim-autopairs',
	event = "InsertEnter",
	opts = {
		-- check_ts = true,
		ignored_next_char = "[%w%.]",
		enable_check_bracket_line = true, -- check bracket in same line

		fast_wrap = {
			map = '<C-k>',
			chars = { '{', '[', '(', '"', "'" },
			pattern = [=[[%'%"%>%]%)%}%,]]=],
			end_key = '$',
			before_key = 'h',
			after_key = 'i',
			cursor_pos_before = true,
			keys = 'qwertyuiopzxcvbnmasdfghjkl',
			manual_position = true,
			highlight = 'Search',
			highlight_grey = 'Comment'
		},
	},
	config = function()
		local npairs = require 'nvim-autopairs'
		npairs.setup()

		npairs.get_rules("'")[1].not_filetypes = { "scheme", "lisp", "racket" }
	end,
}
