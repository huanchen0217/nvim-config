-- Lazy.nvim setup
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup( {
  -- Kickstart plugins
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns',
  require 'kickstart.plugins.indent_line',

  -- Core configuration
  require 'core.settings',
  require 'core.keymaps',
  require 'core.clipboard',
  require 'core.autocmds',
  require 'core.gitmaps',

  -- Plugins
  require 'plugins.autoformat',
  require 'plugins.avante',
  require 'plugins.blink',
  require 'plugins.guess-indent',
  require 'plugins.image',
  require 'plugins.lazydev',
  require 'plugins.lsp',
  require 'plugins.markdown-preview',
  require 'plugins.mini',
  require 'plugins.neoscroll',
  require 'plugins.nvim-cmp',
  require 'plugins.obsidian',
  require 'plugins.render-markdown',
  require 'plugins.telescope',
  require 'plugins.todo-comments',
  require 'plugins.tokyonight',
  require 'plugins.treesitter',
  require 'plugins.which-key',
  
}, {
  -- Lazy.nvim UI configuration
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
