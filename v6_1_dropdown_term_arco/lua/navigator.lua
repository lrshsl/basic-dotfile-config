
return {
	"ray-x/navigator.lua",
	lazy = true,
	dependencies = {
		{"ray-x/guihua.lua", build = "cd lua/fzy && make"},
		"neovim/nvim-lspconfig",
	},
	-- config = function()
	-- 	require("navigator").setup()
	-- end
}
