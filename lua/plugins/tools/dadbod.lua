return {
  {
    'tpope/vim-dadbod',
    cmd = { 'DB', 'DBUI', 'DBUIToggle' },
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = { 'tpope/vim-dadbod', 'kristijanhusak/vim-dadbod-completion' },
    cmd = { 'DBUI', 'DBUIToggle' },
    config = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_win_position = 'left'
      vim.g.db_ui_show_help = 0
      vim.g.db_ui_save_location = vim.fn.stdpath('data') .. '/db_ui_queries'
      vim.g.db_ui_execute_on_save = 0
    end,
  },
  {
    'kristijanhusak/vim-dadbod-completion',
    ft = { 'sql', 'mysql', 'plsql' },
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'sql', 'mysql', 'plsql' },
        callback = function()
          require('cmp').setup.buffer({ sources = { { name = 'vim-dadbod-completion' } } })
        end,
      })
    end,
  },
}
