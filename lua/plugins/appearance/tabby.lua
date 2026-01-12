return {
  'nanozuki/tabby.nvim',
  lazy = false,
  opts = {
    line = function(line)

      local theme = {
        fill =   { fg = '#AAAAAA', bg = '#1E1E1E' },   -- entire tabline background
        current_tab = { fg = '#FFFFFF', bg = '#5A5A5A', style = 'bold' },
        tab =    { fg = '#D0D0D0', bg = '#2E2E2E', style = 'bold' },
        win =    { fg = '#AAAAAA', bg = '#1E1E1E', style = 'italic' },
      }

      return {
        -- Tabs
        line.tabs().foreach(function(tab, i)  -- i is the tab index
          local hl = tab.is_current() and theme.current_tab or theme.tab
          return {
            (i == 1 and '' or line.sep('', hl, theme.fill)),  -- no left wedge for first tab
            tab.in_jump_mode() and tab.jump_key() or tab.number(),
            tab.name(),
            tab.close_btn(''),
            line.sep('', hl, theme.fill),  -- right wedge always
            hl = hl,
            margin = ' ',
          }
        end),
        -- Spacer
        line.spacer(),
        -- Windows in current tab (prettified)
        line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
          return {
            '┃',                              -- vertical separator
            win.is_current() and ' ' or ' ',  -- active/inactive indicator
            win.buf_name(),
            ' ',                              -- padding after buffer name
            hl = theme.win,
            margin = ' ',
          }
        end),
        hl = theme.fill,
      }
    end,
  },
  config = function(_, opts)
    require('tabby').setup(opts)

    -- Keymaps
    vim.api.nvim_set_keymap('n', '<leader>;a', ':tabnew<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>;c', ':tabclose<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>;o', ':tabonly<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>;n', ':tabn<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>;p', ':tabp<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>;mp', ':-tabmove<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>;mn', ':+tabmove<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>;j', ':Tabby jump_to_tab<CR>', { noremap = true, silent = true })

    vim.o.showtabline = 2
  end,
}
