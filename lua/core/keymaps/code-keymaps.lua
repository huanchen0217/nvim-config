-------------
--- C++
-------------

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Space>m', function()
  local mode = vim.fn.input('Build mode (normal/debug/release/opt, x to cancel): ', 'normal')
  if mode == 'x' or mode == '' then
    print 'Build canceled'
    return
  end

  local exe_name = vim.fn.input('Executable name [main]: ', 'main')
  if exe_name == 'x' or exe_name == '' then
    print 'Build canceled'
    return
  end

  vim.cmd 'w'
  vim.cmd('!' .. 'make ' .. mode .. ' EXE=' .. exe_name)
end, opts)
