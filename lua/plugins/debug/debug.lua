return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- DAP UI for visual debugger
    'rcarriga/nvim-dap-ui',

    -- Mason to manage debug adapters
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Optional Go adapter
    'leoluz/nvim-dap-go',
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
    local dap = require('dap')
    local dapui = require('dapui')

    -- Mason DAP setup
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      ensure_installed = {}, -- empty for multi-language flexibility
      handlers = {},
    }

    -- DAP UI setup (latest API)
    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 10,
          position = "bottom",
        },
      },
      expand_lines = true,
      force_buffers = true,
      render = require("dapui.render").default,
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      controls = {
        enabled = true,
        element = "repl",
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
      element_mappings = {},
      floating = {
        max_height = 0.9,
        max_width = 0.5,
        border = "rounded",
        mappings = { close = { "q", "<Esc>" } },
      },
    })

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

    -- Auto-open/close UI on debug session
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Optional Go setup
    pcall(function()
      require('dap-go').setup({
        delve = { detached = vim.fn.has 'win32' == 0 },
      })
    end)
  end,
}
