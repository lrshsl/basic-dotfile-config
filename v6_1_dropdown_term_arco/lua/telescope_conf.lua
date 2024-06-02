return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
        'nvim-lua/plenary.nvim',

        -- Extentions
        'nvim-telescope/telescope-ui-select.nvim'
    },
    lazy = false,
    keys = {
    },
    config = function()
        local ts = require 'telescope'
        ts.setup {
            extentions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {}
                }
            }
        }
        ts.load_extension('ui-select')
    end,
}
