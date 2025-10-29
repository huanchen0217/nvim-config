-- ~/.config/nvim/lua/plugins/calendar.lua
return {
  "itchyny/calendar.vim",
  config = function()
    -- Keymap to open calendar
    vim.keymap.set('n', '<leader>C', ':Calendar<CR>', { noremap = true, silent = true })

    -- Optional: open calendar in a specific view
    -- vim.cmd([[let g:calendar_default_view = 'month']])

    -- Optional: start week on Monday
    vim.cmd([[let g:calendar_first_day = 'monday']])

    -- Optional Google Calendar integration (fill in your credentials)
    -- vim.cmd([[let g:calendar_google_calendar = 1]])
    -- vim.cmd([[let g:calendar_google_task = 1]])
  end
}
