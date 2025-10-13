-- File: lua/plugins/tools/auto-session.lua
return {
  'rmagatti/auto-session',
  config = function()
    local autosession = require('auto-session')

    autosession.setup {
      log_level = 'error',
      auto_session_enabled = true,               -- auto-save sessions
      auto_session_enable_last_session = false,  -- manual restore only
      auto_session_root_dir = vim.fn.stdpath('data') .. '/sessions/',
      pre_save_cmds = { "lua vim.lsp.buf.format({ async = false })" },
    }

    -- Manual restore keybinding
    vim.keymap.set('n', '<leader>tr', function()
      autosession.RestoreSession(vim.fn.getcwd())
    end, { desc = 'Restore Session' })
  end,
}
