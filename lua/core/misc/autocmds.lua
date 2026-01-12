-- Autocommands

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Autocommand to delete old session files
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Clean old persistence.nvim session files',
  group = vim.api.nvim_create_augroup('kickstart-clean-sessions', { clear = true }),
  callback = function()
    local days = 30  -- number of days before a session file is considered old
    local session_dir = vim.fn.stdpath("state") .. "/sessions/"
    local files = vim.fn.glob(session_dir .. "*.lua", true, true)
    local now = os.time()

    for _, file in ipairs(files) do
      local stat = vim.loop.fs_stat(file)
      if stat then
        local age = now - stat.mtime.sec
        if age > days * 24 * 60 * 60 then
          os.remove(file)
        end
      end
    end
  end,
})


-- Before loading a Persistence Session
vim.api.nvim_create_autocmd('User', {
  pattern = 'PersistenceLoadPre',
  callback = function()

    -- Disable Neominimap if open
    pcall(function() vim.cmd('Neominimap Disable') end)
  end,
})
