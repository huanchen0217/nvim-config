return { -- Telescope
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    local telescope_maps = {
      { '<leader>sh', builtin.help_tags, '[S]earch [H]elp' },
      { '<leader>sk', builtin.keymaps, '[S]earch [K]eymaps' },
      { '<leader>sf', builtin.find_files, '[S]earch [F]iles' },
      { '<leader>ss', builtin.builtin, '[S]earch [S]elect Telescope' },
      { '<leader>sw', builtin.grep_string, '[S]earch current [W]ord' },
      { '<leader>sg', builtin.live_grep, '[S]earch by [G]rep' },
      { '<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics' },
      { '<leader>sr', builtin.resume, '[S]earch [R]esume' },
      { '<leader>s.', builtin.oldfiles, '[S]earch Recent Files' },
      { '<leader><leader>', builtin.buffers, 'Find existing buffers' },
    }

    for _, map in ipairs(telescope_maps) do
      vim.keymap.set('n', map[1], map[2], { desc = map[3] })
    end

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = 'Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = 'Search in Open Files' })

    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
