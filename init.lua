-- core
require 'core.lazy'
require 'core.settings'

-- misc
require 'core.misc.clipboard'
require 'core.misc.autocmds'

-- keymaps
require 'core.keymaps.core-keymaps'
require 'core.keymaps.code-keymaps'
require 'core.keymaps.git-keymaps'
require 'core.keymaps.toggle-softwrap'

-- lazy Setup
require('lazy').setup({
  'NMAC427/guess-indent.nvim',

  -- appearance
  require 'plugins.appearance.tokyonight',
  require 'plugins.appearance.todo-comments',
  require 'plugins.appearance.mini',
  require 'plugins.appearance.image-nvim',
  require 'plugins.appearance.indent_line',

  -- editing
  require 'plugins.editing.nvim-lspconfig',
  require 'plugins.editing.nvim-cmp',
  require 'plugins.editing.conform',
  require 'plugins.editing.treesitter',
  require 'plugins.editing.lint',
  require 'plugins.editing.autopairs',

  -- navigation
  require 'plugins.navigation.which-key',
  require 'plugins.navigation.telescope',
  require 'plugins.navigation.neo-tree',
  require 'plugins.navigation.neoscroll',
  require 'plugins.navigation.minimap',

  -- git
  require 'plugins.git.gitsigns',
  require 'plugins.git.neogit',

  -- markdown
  require 'plugins.markdown.markdown-preview',
  require 'plugins.markdown.render-markdown',
  require 'plugins.markdown.obsidian',

  -- tools
  require 'plugins.tools.lazydev',

  -- ai
  require 'plugins.ai.avante',

  -- debug
  require 'plugins.debug.debug',
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
