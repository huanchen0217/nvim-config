return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-vim-test",
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-python")({
          dap = { justMyCode = false },
        }),
        require("neotest-vim-test")({ allow_file_types = { "go", "lua", "rust" } }),
      },
      quickfix = {
        enabled = true,
        open = false,
      },
      output = {
        open_on_run = true,
      },
      summary = {
        open = "botright vsplit | vertical resize 50",
      },
      diagnostic = {
        enabled = true,
        severity = 1,
      },
    })

    -- Keymaps (namespaced under <leader>e)
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map("n", "<leader>Tt", function() neotest.run.run() end, vim.tbl_extend("force", opts, { desc = "Run nearest test" }))
    map("n", "<leader>Tf", function() neotest.run.run(vim.fn.expand("%")) end, vim.tbl_extend("force", opts, { desc = "Run current file tests" }))
    map("n", "<leader>Td", function() neotest.run.run({ strategy = "dap" }) end, vim.tbl_extend("force", opts, { desc = "Debug nearest test" }))
    map("n", "<leader>To", function() neotest.output.open({ enter = true }) end, vim.tbl_extend("force", opts, { desc = "Open test output" }))
    map("n", "<leader>Ts", function() neotest.summary.toggle() end, vim.tbl_extend("force", opts, { desc = "Toggle test summary" }))
  end,
}
