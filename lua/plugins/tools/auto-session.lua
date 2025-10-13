-- File: lua/plugins/tools/auto-session.lua
return {
  'rmagatti/auto-session',
  config = function()
    require('auto-session').setup {
      log_level = 'error',
      auto_session_enable_last_session = true,
      auto_session_root_dir = vim.fn.stdpath('data')..'/sessions/',
      auto_session_enabled = true,
      pre_save_cmds = { "lua vim.lsp.buf.format({ async = false })" },
    }
  end,
}
