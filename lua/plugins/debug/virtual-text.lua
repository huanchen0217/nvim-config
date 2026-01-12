return {
  'theHamsta/nvim-dap-virtual-text',
  dependencies = { 'mfussenegger/nvim-dap' },
  config = function()
    local dap = require('dap')
    
    dap.listeners.after.event_initialized['dap-virtual-text'] = function()
      local vt = require('nvim-dap-virtual-text')
      vt.setup({
        enabled = true,
        enabled_commands = false,
        highlight_changed_variables = true,
        show_stop_reason = true,
        commented = false,
        virt_text_pos = 'eol',
        all_frames = false,
        all_references = false,
      })
    end
  end,
}
