
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
	  "vim", "vimdoc", "lua",
	  "c", "cpp", "rust", "python", "java",
	  "wgsl",
  },
  sync_install = false,
  auto_install = true,

  -- ignore_install = { "javascript" },

  highlight = {
    enable = true,
    disable = { "c", "rust" },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
