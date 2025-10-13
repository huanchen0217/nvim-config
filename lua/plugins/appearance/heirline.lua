-- File: lua/plugins/appearance/heirline.lua
return {
  "rebelot/heirline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")
    local get_hl = utils.get_highlight

    -- Colors
    local colors = {
      blue = "#7aa2f7",
      green = "#9ece6a",
      red = "#f7768e",
      yellow = "#e0af68",
      purple = "#9d7cd8",
      cyan = "#7dcfff",
      gray = "#5c6370",
    }

    -- Mode highlight
    local mode_colors = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      V = colors.blue,
      ["\22"] = colors.blue,
      c = colors.yellow,
      s = colors.orange,
      R = colors.purple,
      t = colors.cyan,
    }

    local function get_mode_color()
      return mode_colors[vim.fn.mode()] or colors.gray
    end

    -- Statusline components
    local StatusLines = {
      -- Left section
      {
        provider = function()
          return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        end,
        hl = { fg = colors.blue, bold = true },
        right_sep = "",
      },
      {
        provider = function()
          local mode = vim.fn.mode()
          local alias = {
            n = "NORMAL",
            i = "INSERT",
            v = "VISUAL",
            V = "V-LINE",
            ["\22"] = "V-BLOCK",
            c = "COMMAND",
            s = "SELECT",
            R = "REPLACE",
            t = "TERMINAL",
          }
          return " " .. (alias[mode] or mode) .. " "
        end,
        hl = function()
          return { fg = get_mode_color(), bold = true, bg = colors.gray }
        end,
        left_sep = "",
        right_sep = "",
      },
      -- Git branch
      {
        provider = "git_branch",
        hl = { fg = colors.purple, bold = true },
        icon = " ",
        left_sep = " ",
      },
      -- Diff
      {
        condition = conditions.is_git_repo,
        provider = "git_diff_added",
        hl = { fg = colors.green },
        icon = "  ",
        left_sep = " ",
      },
      {
        condition = conditions.is_git_repo,
        provider = "git_diff_removed",
        hl = { fg = colors.red },
        icon = "  ",
        left_sep = " ",
      },
      {
        condition = conditions.is_git_repo,
        provider = "git_diff_changed",
        hl = { fg = colors.yellow },
        icon = " 柳",
        left_sep = " ",
      },

      -- Middle section: filename
      {
        provider = function()
          local file = vim.fn.expand("%:t")
          if file == "" then
            return "[No Name]"
          else
            return file
          end
        end,
        hl = { fg = colors.cyan, bold = true },
        left_sep = "",
        right_sep = "",
      },

      -- Diagnostics
      {
        condition = conditions.has_diagnostics,
        provider = "diagnostics",
        hl = { fg = colors.red },
        icon = " ",
        left_sep = " ",
        right_sep = " ",
      },

      -- Right section
      {
        provider = "filetype",
        hl = { fg = colors.yellow, bold = true },
        left_sep = "",
        right_sep = "",
      },
      {
        provider = "progress",
        hl = { fg = colors.blue, bold = true },
        left_sep = " ",
      },
      {
        provider = "location",
        hl = { fg = colors.green, bold = true },
        left_sep = " ",
      },
    }

    -- Setup Heirline
    require("heirline").setup({
      statusline = StatusLines,
      opts = { colors = colors, disable_winbar_cb = function() return false end },
    })
  end,
}
