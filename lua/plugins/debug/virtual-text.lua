return {
  'theHamsta/nvim-dap-virtual-text',
  dependencies = { 'mfussenegger/nvim-dap' },
  config = function()
    require('nvim-dap-virtual-text').setup({
      enabled = true,
      enabled_commands = false,  -- keep clean command space
      highlight_changed_variables = true,
      show_stop_reason = true,
      commented = false,         -- no prefix, just plain values
      virt_text_pos = 'eol',     -- at end of line (cleanest)
      all_frames = false,        -- only current frame
      all_references = false,
    })
  end,
}
