return {
  "rebelot/heirline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local conditions = require("heirline.conditions")
    local Heirline = require("heirline")

    Heirline.setup({
      statusline = {
        -- Mode
        { provider = function() return " " .. vim.fn.mode():upper() end, hl = { fg = "green" } },

        -- Git branch
        { provider = "git_branch", hl = { fg = "orange" } },

        -- Diagnostics
        { provider = "diagnostics", hl = { fg = "red" } },

        -- Filename
        { provider = "file_name", hl = { fg = "blue" }, 
          truncation = { priority = 1 }
        },

        -- Fill space
        { provider = "%=", },

        -- File info
        { provider = "file_type", hl = { fg = "yellow" } },
        { provider = "position", hl = { fg = "cyan" } },
      }
    })
  end,
}
