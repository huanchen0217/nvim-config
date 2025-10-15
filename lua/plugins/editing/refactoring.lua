return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    local refactor = require('refactoring')

    refactor.setup({
      prompt_func_return_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
      },
      prompt_func_param_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
      },
    })

    -- Keymaps
    vim.keymap.set(
      'v',
      '<leader>r',
      function() require('refactoring').select_refactor() end,
      { noremap = true, silent = true, desc = 'Select refactor' }
    )

    vim.keymap.set(
      'n',
      '<leader>rb',
      function() require('refactoring').debug.printf({ below = false }) end,
      { noremap = true, silent = true, desc = 'Add printf debug' }
    )

    vim.keymap.set(
      'n',
      '<leader>rc',
      function() require('refactoring').debug.cleanup({}) end,
      { noremap = true, silent = true, desc = 'Cleanup debug prints' }
    )
  end,
}
