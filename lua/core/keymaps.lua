-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<Leader>op', function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == '' then
    print 'No file in current buffer'
    return
  end
  vim.fn.jobstart({ 'open', file }, { detach = true })
end, { desc = 'Open current file with default macOS app' })

-- Window navigation
vim.keymap.set('n', '<Up>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<Down>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<Left>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<Right>', '<C-w>l', { noremap = true, silent = true })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- C++
vim.keymap.set('n', '<leader>n', ':Neotree toggle<CR>', { silent = true, noremap = true })

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Space>m', function()
  local mode = vim.fn.input('Build mode (normal/debug/release/opt): ', 'normal')
  local exe_name = vim.fn.input('Executable name [main]: ', 'main')
  vim.cmd 'w'
  vim.cmd('!' .. 'make ' .. mode .. ' EXE=' .. exe_name)
end, opts)

-- JavaScript
vim.keymap.set('n', '<leader>rj', ':w<CR>:!node %<CR>')
