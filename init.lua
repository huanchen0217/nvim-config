-- core
require 'core.lazy'
require 'core.settings'

-- misc
require 'core.misc.clipboard'
require 'core.misc.autocmds'
require 'core.misc.avante-msg-intercept'

-- keymaps
require 'core.keymaps.core-keymaps'
require 'core.keymaps.code-keymaps'
require 'core.keymaps.git-keymaps'
require 'core.keymaps.bazel-keymaps'

-- lazy Setup
require('lazy').setup({
  'NMAC427/guess-indent.nvim',

  -- appearance
  require 'plugins.appearance.tokyonight',
  require 'plugins.appearance.todo-comments',
  require 'plugins.appearance.mini',
  require 'plugins.appearance.image-nvim',
  require 'plugins.appearance.indent_line',
  require 'plugins.appearance.lualine',
  require 'plugins.appearance.calendar',
  require 'plugins.appearance.pomo',
  require 'plugins.appearance.notify',

  -- editing
  require 'plugins.editing.nvim-lspconfig',
  require 'plugins.editing.nvim-cmp',
  require 'plugins.editing.treesitter',
  require 'plugins.editing.lint',
  require 'plugins.editing.autopairs',
  require 'plugins.editing.refactoring',

  -- navigation
  require 'plugins.navigation.which-key',
  require 'plugins.navigation.telescope',
  require 'plugins.navigation.neo-tree',
  require 'plugins.navigation.neoscroll',
  require 'plugins.navigation.minimap',
  require 'plugins.navigation.harpoon',

  -- git
  require 'plugins.git.gitsigns',
  require 'plugins.git.neogit',

  -- markdown
  require 'plugins.markdown.markdown-preview',
  require 'plugins.markdown.render-markdown',
  require 'plugins.markdown.obsidian',

  -- tools
  require 'plugins.tools.lazydev',
  require 'plugins.tools.toggleterm',
  require 'plugins.tools.project-nvim',
  require 'plugins.tools.dadbod',
  require 'plugins.tools.rest',

  -- testing
  require 'plugins.testing.neotest',

  -- ai
  require 'plugins.ai.neocodeium',

  -- debug
  require 'plugins.debug.debug',
  require 'plugins.debug.virtual-text',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd    = '⌘',
      event  = '📅',
      ft     = '📂',
      keys   = '🗝',
      plugin = '🔌',
      run    = '💻',
      req    = '🌙',
      source = '📄',
      start  = '🚀',
      task   = '📌',
      lazy   = '💤',
    },
  },
})
