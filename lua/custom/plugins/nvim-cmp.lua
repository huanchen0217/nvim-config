return { -- Autocompletion
'hrsh7th/nvim-cmp',
dependencies = {
  'hrsh7th/cmp-buffer',
  'epwalsh/obsidian.nvim',
},
config = function()
  local cmp = require 'cmp'
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
      ['<C-Space>'] = cmp.mapping.complete(), -- manual trigger
    },
    sources = cmp.config.sources {
      { name = 'obsidian' },
      { name = 'buffer' },
    },
    completion = {
      autocomplete = false, -- disables auto popup
      keyword_length = 2, -- optional: only start completions after 2 chars
    },
  }
end,
}