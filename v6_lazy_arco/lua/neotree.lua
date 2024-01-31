return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim",
	},
	keys = {
		{ "<leader>o", "<cmd>Neotree toggle<cr>", desc = "Open Neotree" },
	},
	config = {
		window = {
			mappings = {
				["<tab>"] = "toggle_node",
				["<esc>"] = "cancel",
				["s"] = "open_vsplit",
				["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = false } },

				["a"] = {
					"add",   -- supports brace expansion ("x{a,b,c}" -> xa,xb,xc)
					config = {
						show_path = "relative" -- "none", "relative", "absolute"
					}
				},
				["e"] = "", -- unmap e
				["A"] = "add_directory",
				["m"] = "move",
				["r"] = "rename",

				["d"] = "delete",
				["x"] = "cut_to_clipboard",
				["y"] = "copy_to_clipboard",
				["p"] = "paste_from_clipboard",

				["R"] = "refresh",
				["?"] = "show_help",

				["-"] = "navigate_up",
				["<C-]>"] = "set_root",
				["H"] = "toggle_hidden",

				["/"] = "fuzzy_finder",
			}
		}
	}
}
