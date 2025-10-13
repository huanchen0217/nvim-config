-- File: lua/plugins/tools/auto-session.lua
return {
  'rmagatti/auto-session',
  config = function()
    require('auto-session').setup {
      log_level = 'error',
      auto_session_enabled = true,               -- still auto-save sessions
      auto_session_enable_last_session = false,  -- disable auto-restore
      auto_session_root_dir = vim.fn.stdpath('data') .. '/sessions/',
      pre_save_cmds = { "lua vim.lsp.buf.format({ async = false })" },
    }

    -- Optional keybinding to restore manually
    vim.keymap.set('n', '<leader>rs', ':RestoreSession<CR>', { desc = 'Restore Session' })
  end,
}
