return {
  "rest-nvim/rest.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("rest-nvim").setup({
      result_split_horizontal = false,
      skip_ssl_verification = true,
      highlight = { enabled = true, timeout = 150 },
    })

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Send request
    map("n", "<leader>rr", "<Plug>RestNvim", opts)
    -- Show last response
    map("n", "<leader>rl", "<Plug>RestNvimLast", opts)
  end,
}
