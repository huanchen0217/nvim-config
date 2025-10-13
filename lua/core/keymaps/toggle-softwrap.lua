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

-- Keymap for all buffers
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>tw', ':lua ToggleWrap()<CR>', { noremap = true, silent = true })
  end,
})
