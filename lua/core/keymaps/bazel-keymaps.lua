return {
  dependencies = { "akinsho/toggleterm.nvim" },
  config = function()
    local Terminal = require("toggleterm.terminal").Terminal

    local function run_bazel(cmd, target)
      target = target or "//..."
      local bazel_term = Terminal:new({
        cmd = "bazel " .. cmd .. " " .. target,
        direction = "horizontal",
        close_on_exit = false,
        hidden = true,
      })
      bazel_term:toggle()
    end

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map("n", "<leader>zb", function() run_bazel("build") end, vim.tbl_extend("force", opts, { desc = "bazel build" }))
    map("n", "<leader>zr", function() run_bazel("run") end, vim.tbl_extend("force", opts, { desc = "bazel run" }))
    map("n", "<leader>zt", function() run_bazel("test") end, vim.tbl_extend("force", opts, { desc = "bazel test" }))
    map("n", "<leader>zq", function() run_bazel("query") end, vim.tbl_extend("force", opts, { desc = "bazel query" }))
  end,
}
