-- Neogit Setup
return {
  'NeogitOrg/neogit',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    local neogit = require 'neogit'

    neogit.setup {
      disable_commit_confirmation = true, -- skips confirmation prompt
      integrations = {
        telescope = true, -- allows using telescope for fuzzy finding branches/commits
      },
      signs = {
        section = { '▸', '▾' },
        item = { '▸', '▾' },
      },
    }

    -- Keymap to open Neogit
    vim.keymap.set('n', '<leader>gn', function()
      neogit.open()
    end, { desc = 'Open Neogit' })
  end,
}
