return { -- Colorscheme
  'folke/tokyonight.nvim',
  priority = 1000,
  config = function()
    require('tokyonight').setup {
      styles = { comments = { italic = false } },
      on_colors = function(colors)
        -- Define colors here
      end,
      on_highlights = function(highlights, colors)
        -- Define highlights here
      end,
    }
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}

