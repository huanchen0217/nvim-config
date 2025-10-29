-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--Open file with default macOS app
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

-- Reset Checklists in a Files
vim.keymap.set('n', '<leader>tr', function()
  vim.cmd([[%s/- \[[xX]\]/- [ ]/g]])
end, { desc = 'Reset all checkboxes in file' })

-- Global toggle for soft wrapping
local wrap_enabled = false

function ToggleWrap()
  if wrap_enabled then
    -- Disable wrap
    vim.wo.wrap = false
    vim.wo.linebreak = false
    wrap_enabled = false
  else
    -- Enable wrap
    vim.wo.wrap = true
    vim.wo.linebreak = true
    wrap_enabled = true
  end
end

vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>tw', ':lua ToggleWrap()<CR>', { noremap = true, silent = true })
  end,
})
