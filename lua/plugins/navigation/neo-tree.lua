return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- optional but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>tn', ':Neotree toggle<CR>', desc = '[N]eoTree toggle', silent = true, noremap = true },
  },
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,     -- show dotfiles
        hide_gitignored = false,   -- show gitignored files
        never_show = { ".DS_Store", "thumbs.db" },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
