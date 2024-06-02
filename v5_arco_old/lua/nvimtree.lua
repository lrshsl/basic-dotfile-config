local function my_on_attach(bufnr)
	local api = require('nvim-tree.api')
	local function opts(desc)
		return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)
	vim.keymap.set('n', 'r', api.fs.rename_sub, opts('rename'))
	vim.keymap.del('n', 'e', { buffer = bufnr })
	vim.keymap.del('n', 'E', { buffer = bufnr })
end


require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
	-- remove_keymaps = true,
	on_attach = my_on_attach,
})
