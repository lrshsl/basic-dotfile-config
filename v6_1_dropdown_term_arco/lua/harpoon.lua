local harpoon

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>gh', function () harpoon.ui:toggle_quick_menu(harpoon:list()) end },
    { '<leader>ga', function () harpoon:list():append() end },
    { '<leader>gj', function () harpoon:list():select(1) end },
    { '<leader>gk', function () harpoon:list():select(2) end },
    { '<leader>gl', function () harpoon:list():select(3) end },
    { '<leader>g;', function () harpoon:list():select(4) end },
  },
  config = function ()
    harpoon = require("harpoon"):setup()
  end,
}
