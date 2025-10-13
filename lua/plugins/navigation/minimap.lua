return {
  'Isrothy/neominimap.nvim',
  version = 'v3.x.x',
  lazy = false, -- Load immediately
  keys = {
    -- Global Minimap Controls
    { '<leader>nm', '<cmd>Neominimap Toggle<cr>', desc = 'Toggle global minimap' },
    { '<leader>no', '<cmd>Neominimap Enable<cr>', desc = 'Enable global minimap' },
    { '<leader>nc', '<cmd>Neominimap Disable<cr>', desc = 'Disable global minimap' },
    { '<leader>nr', '<cmd>Neominimap Refresh<cr>', desc = 'Refresh global minimap' },

    -- Window-Specific Minimap Controls
    { '<leader>nwt', '<cmd>Neominimap WinToggle<cr>', desc = 'Toggle minimap for current window' },
    { '<leader>nwr', '<cmd>Neominimap WinRefresh<cr>', desc = 'Refresh minimap for current window' },
    { '<leader>nwo', '<cmd>Neominimap WinEnable<cr>', desc = 'Enable minimap for current window' },
    { '<leader>nwc', '<cmd>Neominimap WinDisable<cr>', desc = 'Disable minimap for current window' },

    -- Focus Controls
    { '<leader>nf', '<cmd>Neominimap Focus<cr>', desc = 'Focus on minimap' },
    { '<leader>nu', '<cmd>Neominimap Unfocus<cr>', desc = 'Unfocus minimap' },
    { '<leader>ns', '<cmd>Neominimap ToggleFocus<cr>', desc = 'Switch focus on minimap' },
  },
  opts = {
    auto_enable = true, -- Enable minimap on startup
    -- Optional: add any other Neominimap config here
  },
  -- Optional: set wrap and sidescrolloff only when minimap is active
  config = function(_, opts)
    vim.api.nvim_create_autocmd('User', {
      pattern = 'NeominimapOpen',
      callback = function()
        vim.wo.wrap = false
        vim.wo.sidescrolloff = 36
      end,
    })
  end,
}
