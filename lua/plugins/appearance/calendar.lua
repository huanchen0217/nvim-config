-- ~/.config/nvim/lua/plugins/calendar.lua
return {
  "itchyny/calendar.vim",
  config = function()
    -- === CORE LAUNCH ===
    vim.keymap.set('n', '<leader>C<CR>', ':Calendar<CR>', { desc = 'Open Calendar', noremap = true, silent = true })
    vim.keymap.set('n', '<leader>Cy', ':Calendar -view=year<CR>', { desc = 'Year view', noremap = true, silent = true })
    vim.keymap.set('n', '<leader>Cm', ':Calendar -view=month<CR>', { desc = 'Month view', noremap = true, silent = true })
    vim.keymap.set('n', '<leader>Cw', ':Calendar -view=week<CR>', { desc = 'Week view', noremap = true, silent = true })
    vim.keymap.set('n', '<leader>Cd', ':Calendar -view=day<CR>', { desc = 'Day view', noremap = true, silent = true })
    vim.keymap.set('n', '<leader>Cc', ':Calendar -view=clock<CR>', { desc = 'Clock view', noremap = true, silent = true })

    -- === SPLIT OPTIONS ===
    vim.keymap.set('n', '<leader>Csv', ':Calendar -view=year -split=vertical -width=27<CR>', { desc = 'Calendar vertical split', noremap = true, silent = true })
    vim.keymap.set('n', '<leader>Csh', ':Calendar -view=year -split=horizontal -height=12<CR>', { desc = 'Calendar horizontal split', noremap = true, silent = true })

    -- === SETTINGS ===
    vim.cmd([[
      let g:calendar_first_day = 'monday'        " start week on Monday
      let g:calendar_frame = 'default'           " default frame if UI glitches
    ]])

    -- === OPTIONAL GOOGLE INTEGRATION ===
    -- Uncomment and properly configure to enable
    -- vim.cmd([[
    --   let g:calendar_google_calendar = 1
    --   let g:calendar_google_task = 1
    --   source ~/.cache/calendar.vim/credentials.vim
    -- ]])
  end
}
