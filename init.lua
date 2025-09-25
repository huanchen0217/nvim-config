-- Basic settings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.g.mkdp_echo_preview_url = 1

-- Editor options
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.mousehide = true
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Clipboard setup
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<Leader>op', function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == '' then
    print 'No file in current buffer'
    return
  end
  vim.fn.jobstart({ 'open', file }, { detach = true })
end, { desc = 'Open current file with default macOS app' })

-- Window navigation
vim.keymap.set('n', '<Up>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<Down>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<Left>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<Right>', '<C-w>l', { noremap = true, silent = true })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- C++
vim.keymap.set('n', '<leader>n', ':Neotree toggle<CR>', { silent = true, noremap = true })

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Space>m', function()
  local mode = vim.fn.input('Build mode (normal/debug/release/opt): ', 'normal')
  local exe_name = vim.fn.input('Executable name [main]: ', 'main')
  vim.cmd 'w'
  vim.cmd('!' .. 'make ' .. mode .. ' EXE=' .. exe_name)
end, opts)

-- JavaScript
vim.keymap.set('n', '<leader>rj', ':w<CR>:!node %<CR>')

-- Autocommands
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

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

require('lazy').setup({
  'NMAC427/guess-indent.nvim',

  -- Core
require('custom.core.git-keymaps'),

  -- Plugins
  require('custom.plugins.gitsigns'),
  require('custom.plugins.which-key'),
  require('custom.plugins.telescope'),
  require('custom.plugins.lazydev'),
  require('custom.plugins.nvim-lspconfig'),
  require('custom.plugins.nvim-cmp'),
  require('custom.plugins.neoscroll'),
  require('custom.plugins.conform'),
  require('custom.plugins.blink-cmp'),
  require('custom.plugins.tokyonight'),
  require('custom.plugins.todo-comments'),
  require('custom.plugins.mini'),
  require('custom.plugins.treesitter'),
  require('custom.plugins.avante'),
  require('custom.plugins.render-markdown'),
  require('custom.plugins.markdown-preview'),
  require('custom.plugins.image-nvim'),
  require('custom.plugins.obsidian'),

  -- Kickstart plugins
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns',
  require 'kickstart.plugins.indent_line',

  { import = 'custom.plugins' },
}, {
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

--Git prefix
local git_prefix = '<leader>g'

-- Stage submenu
vim.keymap.set('n', git_prefix .. 'sa', '<cmd>git add -A<CR>', { desc = 'Stage All Changes' })
vim.keymap.set('n', git_prefix .. 'sf', '<cmd>git add %<CR>', { desc = 'Stage Current File' })
vim.keymap.set('n', git_prefix .. 'sd', '<cmd>git restore --staged %<CR>', { desc = 'Unstage Current File' })

-- Commit submenu
vim.keymap.set(
  'n',
  git_prefix .. 'cc',
  "<cmd>lua vim.fn.inputsave(); local msg = vim.fn.input('Commit message: '); vim.fn.inputrestore(); vim.cmd('!git commit -m \"'..msg..'\"')<CR>",
  { desc = 'Commit with Message' }
)
vim.keymap.set('n', git_prefix .. 'ca', '<cmd>git commit --amend<CR>', { desc = 'Amend Last Commit' })

-- Push submenu
vim.keymap.set('n', git_prefix .. 'pp', '<cmd>git push<CR>', { desc = 'Push Current Branch' })
vim.keymap.set('n', git_prefix .. 'pf', '<cmd>git push -f<CR>', { desc = 'Force Push' })

-- Pull submenu
vim.keymap.set('n', git_prefix .. 'lp', '<cmd>git pull<CR>', { desc = 'Pull Current Branch' })
vim.keymap.set('n', git_prefix .. 'lr', '<cmd>git pull --rebase<CR>', { desc = 'Pull with Rebase' })

-- Diff submenu
vim.keymap.set('n', git_prefix .. 'df', '<cmd>git diff %<CR>', { desc = 'Diff Current File' })
vim.keymap.set('n', git_prefix .. 'da', '<cmd>git diff<CR>', { desc = 'Diff All Files' })

-- Status
vim.keymap.set('n', git_prefix .. 'S', '<cmd>git status<CR>', { desc = 'Status' })

-- Log submenu
vim.keymap.set('n', git_prefix .. 'Ll', '<cmd>git log --oneline<CR>', { desc = 'Log Oneline' })
vim.keymap.set('n', git_prefix .. 'Lg', '<cmd>git log --graph --decorate --oneline<CR>', { desc = 'Graph Log' })
vim.keymap.set('n', git_prefix .. 'Lp', '<cmd>git log -p<CR>', { desc = 'Log with Patch' })

-- Branch submenu
vim.keymap.set(
  'n',
  git_prefix .. 'Cc',
  "<cmd>lua vim.fn.inputsave(); local branch = vim.fn.input('Checkout branch: '); vim.fn.inputrestore(); vim.cmd('!git checkout '..branch)<CR>",
  { desc = 'Checkout Branch' }
)
vim.keymap.set(
  'n',
  git_prefix .. 'Cn',
  "<cmd>lua vim.fn.inputsave(); local branch = vim.fn.input('New branch: '); vim.fn.inputrestore(); vim.cmd('!git checkout -b '..branch)<CR>",
  { desc = 'New Branch' }
)
vim.keymap.set(
  'n',
  git_prefix .. 'Cd',
  "<cmd>lua vim.fn.inputsave(); local branch = vim.fn.input('Delete branch: '); vim.fn.inputrestore(); vim.cmd('!git branch -D '..branch)<CR>",
  { desc = 'Delete Branch' }
)
vim.keymap.set('n', git_prefix .. 'Cl', '<cmd>git branch<CR>', { desc = 'List Branches' })

-- Stash submenu
vim.keymap.set('n', git_prefix .. 'ts', '<cmd>git stash<CR>', { desc = 'Stash Changes' })
vim.keymap.set('n', git_prefix .. 'tp', '<cmd>git stash pop<CR>', { desc = 'Pop Stash' })
vim.keymap.set('n', git_prefix .. 'tl', '<cmd>git stash list<CR>', { desc = 'List Stashes' })
vim.keymap.set(
  'n',
  git_prefix .. 'td',
  "<cmd>lua vim.fn.inputsave(); local idx = vim.fn.input('Drop stash index: '); vim.fn.inputrestore(); vim.cmd('!git stash drop stash@{'..idx..'}')<CR>",
  { desc = 'Drop Stash' }
)

-- Reset submenu
vim.keymap.set('n', git_prefix .. 'rh', '<cmd>git reset HEAD %<CR>', { desc = 'Reset Current File' })
vim.keymap.set('n', git_prefix .. 'ra', '<cmd>git reset --hard<CR>', { desc = 'Reset All (Hard)' })

-- Cherry-pick
vim.keymap.set(
  'n',
  git_prefix .. 'yc',
  "<cmd>lua vim.fn.inputsave(); local commit = vim.fn.input('Commit hash: '); vim.fn.inputrestore(); vim.cmd('!git cherry-pick '..commit)<CR>",
  { desc = 'Cherry-pick Commit' }
)

-- Tag submenu
vim.keymap.set(
  'n',
  git_prefix .. 'ga',
  "<cmd>lua vim.fn.inputsave(); local tag = vim.fn.input('Tag name: '); vim.fn.inputrestore(); vim.cmd('!git tag '..tag)<CR>",
  { desc = 'Add Tag' }
)
vim.keymap.set('n', git_prefix .. 'gl', '<cmd>git tag<CR>', { desc = 'List Tags' })
vim.keymap.set(
  'n',
  git_prefix .. 'gd',
  "<cmd>lua vim.fn.inputsave(); local tag = vim.fn.input('Delete tag: '); vim.fn.inputrestore(); vim.cmd('!git tag -d '..tag)<CR>",
  { desc = 'Delete Tag' }
)
vim.keymap.set('n', git_prefix .. 'gp', '<cmd>git push --tags<CR>', { desc = 'Push Tags' })