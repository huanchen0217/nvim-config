-- File: lua/plugins/tools/toggleterm.lua
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      size = 20,
      open_mapping = [[<leader>tt]],   -- only in normal mode
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      persist_size = true,
      direction = 'float',
      insert_mappings = false,          -- disable leader mappings in insert mode
    }
  end,
}
