return {
  'monkoose/neocodeium',
  event = 'VeryLazy',
  config = function()
    local neocodeium = require 'neocodeium'
    local cmp = require 'cmp'

    -- clear ghost text when cmp menu opens
    cmp.event:on('menu_opened', function()
      neocodeium.clear()
    end)

    -- setup NeoCodeium
    neocodeium.setup {
      manual = false, -- automatic suggestions
      show_label = true,
      debounce = true,
      max_lines = 10000,
      silent = true,
      filter = function()
        return not cmp.visible()
      end,
      filetypes = {
        help = false,
        gitcommit = false,
        gitrebase = false,
        ['.'] = false,
      },
    }

    -- keymaps (insert mode)
    vim.keymap.set('i', '<A-f>', neocodeium.accept)
    vim.keymap.set('i', '<A-w>', neocodeium.accept_word)
    vim.keymap.set('i', '<A-a>', neocodeium.accept_line)
    vim.keymap.set('i', '<A-e>', neocodeium.cycle_or_complete)
    vim.keymap.set('i', '<A-r>', function()
      neocodeium.cycle_or_complete(-1)
    end)
    vim.keymap.set('i', '<A-c>', neocodeium.clear)

    -- keymap for NeoCodeium chat in normal mode
    vim.keymap.set('n', '<leader>tNc', function()
      require('neocodeium.commands').toggle()
    end, { noremap = true, silent = true })

    -- nvim-cmp setup
    cmp.setup {
      completion = { autocomplete = false }, -- manual cmp popup
      mapping = cmp.mapping.preset.insert {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      },
    }
  end,
}
