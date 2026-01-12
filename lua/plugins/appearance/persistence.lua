return {
  'folke/persistence.nvim',
  lazy = false, -- load immediately
  opts = {
    dir = vim.fn.stdpath 'state' .. '/sessions/',
    need = 1,
    branch = true,
  },
  config = function(_, opts)
    local p = require 'persistence'
    p.setup(opts)

    local map = vim.keymap.set
    map('n', '<leader>Ps', function()
      p.load()
    end, { desc = 'Load session (current dir)' })
    map('n', '<leader>PS', function()
      p.select()
    end, { desc = 'Select session' })
    map('n', '<leader>Pd', function()
      p.stop()
    end, { desc = 'Stop persistence' })
    map('n', '<leader>Pc', function() end, { desc = 'Cancel / no-op' })
    map('n', '<leader>Pm', function()
      require('persistence').save()
    end, { desc = 'Manually save session' })
  end,
}
