return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
			message = {
				-- Messages shown by lsp servers
				enabled = true,
				view = "notify", -- Show as bottom split
				opts = {},
			},
		},
		presets = {
			bottom_search = false,  -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false,     -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true,  -- add a border to hover docs and signature help
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "written",
				},
				opts = { skip = true },
			},
		},
		messages = {
			-- NOTE: If you enable messages, then the cmdline is enabled automatically.
			-- This is a current Neovim limitation.
			enabled = true,        -- enables the Noice messages UI
			view = "notify",       -- default view for messages
			view_error = "notify", -- view for errors
			view_warn = "notify",  -- view for warnings
			view_history = "messages", -- view for :messages
			view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
		},
		commands = {
			diagnostics = {
				-- options for the message history that you get with `:Noice`
				view = "split",
				opts = { enter = true, format = "details" },
				filter = {
					any = {
						{ event = "lsp", },
					},
				},
				filter_opts = { reverse = true },
			},
			history = {
				-- options for the message history that you get with `:Noice`
				view = "split",
				opts = { enter = true, format = "details" },
				filter = {
					any = {
						{ event = "notify" },
						{ error = true },
						{ warning = true },
						{ event = "msg_show", kind = { "" } },
						{ event = "lsp",      kind = "message" },
					},
				},
			},
			-- :Noice last
			last = {
				view = "popup",
				opts = { enter = true, format = "details" },
				filter = {
					any = {
						{ event = "notify" },
						{ error = true },
						{ warning = true },
						{ event = "msg_show", kind = { "" } },
						{ event = "lsp",      kind = "message" },
					},
				},
				filter_opts = { count = 1 },
			},
			-- :Noice errors
			errors = {
				-- options for the message history that you get with `:Noice`
				view = "popup",
				opts = { enter = true, format = "details" },
				filter = { error = true },
				filter_opts = { reverse = true },
			},
			all = {
				-- options for the message history that you get with `:Noice`
				view = "split",
				opts = { enter = true, format = "details" },
				filter = {},
			},
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		-- "rcarriga/nvim-notify",

	}
}
