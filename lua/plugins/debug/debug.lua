return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',       -- Visual debugger UI
    'nvim-neotest/nvim-nio',      -- Required dependency
    'mason-org/mason.nvim',       -- Mason to manage adapters
    'jay-babu/mason-nvim-dap.nvim', -- Mason DAP bridge
    'leoluz/nvim-dap-go',         -- Optional Go adapter
  },
  keys = {
    { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
    { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
    { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
    { '<F3>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
    { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    { '<leader>B', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set Breakpoint' },
    { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: Toggle DAP UI' },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Mason DAP setup for multi-language support
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      ensure_installed = {},  -- leave empty for multi-language flexibility
      handlers = {},
    }

    -- DAP UI setup (minimal, safe)
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Nerd font breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = {
      Breakpoint = '',
      BreakpointCondition = '',
      BreakpointRejected = '',
      LogPoint = '',
      Stopped = '',
    }
    for type, icon in pairs(breakpoint_icons) do
      local sign_name = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(sign_name, { text = icon, texthl = hl, numhl = hl })
    end

    -- Auto-open/close DAP UI on debug session start/exit
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Optional Go adapter setup
    pcall(function()
      require('dap-go').setup {
        delve = { detached = vim.fn.has 'win32' == 0 },
      }
    end)
  end,
}
