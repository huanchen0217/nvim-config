return { -- Autocompletion
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
  },
  config = function()
    local cmp = require 'cmp'

    -- state variables
    local auto_complete_enabled = true
    local max_item_count = 10

    -- function to toggle autocomplete globally
    local function toggle_nvim_cmp()
      auto_complete_enabled = not auto_complete_enabled
      cmp.setup {
        completion = {
          autocomplete = auto_complete_enabled and { cmp.TriggerEvent.TextChanged } or false,
          keyword_length = 2,
        },
      }
      vim.notify 'Toggle nvim-cmp'
    end

    -- function to dynamically change max_item_count
    local function set_max_items()
      local input = vim.fn.input('Set max completion items: ', tostring(max_item_count))
      local num = tonumber(input)
      if num and num > 0 then
        max_item_count = num
        cmp.setup {
          sources = cmp.config.sources {
            { name = 'nvim_lsp', max_item_count = max_item_count },
            { name = 'buffer', max_item_count = max_item_count },
            { name = 'path', max_item_count = max_item_count },
            { name = 'luasnip', max_item_count = max_item_count },
            { name = 'obsidian', max_item_count = max_item_count },
          },
        }
        vim.notify('Max completion items set to ' .. max_item_count)
      else
        vim.notify 'Invalid number'
      end
    end

    -- initial setup: starts enabled
    cmp.setup {
      window = {
        completion = cmp.config.window.bordered {
          winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
          side_padding = 1,
          col_offset = -3,
        },
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<C-c>'] = cmp.mapping.complete(), -- manual trigger
      },
      sources = cmp.config.sources {
        { name = 'nvim_lsp', max_item_count = max_item_count },
        { name = 'buffer', max_item_count = max_item_count },
        { name = 'path', max_item_count = max_item_count },
        { name = 'luasnip', max_item_count = max_item_count },
        { name = 'obsidian', max_item_count = max_item_count },
      },
      completion = {
        autocomplete = { cmp.TriggerEvent.TextChanged },
        keyword_length = 2,
      },
    }

    -- keymaps
    vim.keymap.set('n', '<leader>tcc', toggle_nvim_cmp, { desc = 'Toggle nvim-cmp' })
    vim.keymap.set('n', '<leader>tcm', set_max_items, { desc = 'Set max completion items' })
  end,
}
