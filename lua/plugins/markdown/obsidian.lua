return {
  -- Obsidian
  'epwalsh/obsidian.nvim',
  version = '*', -- latest release
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'hrsh7th/nvim-cmp',
    'nvim-treesitter/nvim-treesitter',
    'neovim/nvim-lspconfig',
  },
  config = function()
    require('obsidian').setup {
      follow_url_func = function(url)
        vim.fn.jobstart { 'open', url } -- macOS
      end,
      ui = {
        enable = false,
        checkboxes = {
          ['x'] = { char = '󰱒', hl_group = 'ObsidianDone' },
        },
      },
      workspaces = {
        {
          name = 'personal',
          path = '~/Library/Mobile Documents/com~apple~CloudDocs/HuanOS/',
        },
      },
      disable_frontmatter = true,
      notes_subdir = '+Inbox',
      new_notes_location = 'notes_subdir',
      note_id_func = function(title)
        return title or tostring(os.time())
      end,
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      picker = {
        name = 'telescope.nvim',
      },
      mappings = {
        ['G'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
          desc = 'Go to Obsidian link',
        },
        ['<leader>c'] = {
          action = function()
            return require('obsidian').util.toggle_checkbox()
          end,
          desc = 'Toggle [C]heckbox',
        },
      },
    }
  end,
}
