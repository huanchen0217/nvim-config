-- Git prefix
local git_prefix = '<leader>g'

-- Stage submenu
vim.keymap.set('n', git_prefix .. 'sa', '<cmd>!git add -A<CR>', { desc = 'Stage All Changes' })
vim.keymap.set('n', git_prefix .. 'sf', '<cmd>!git add %<CR>', { desc = 'Stage Current File' })
vim.keymap.set('n', git_prefix .. 'sd', '<cmd>!git restore --staged %<CR>', { desc = 'Unstage Current File' })

-- Commit submenu
vim.keymap.set(
  'n',
  git_prefix .. 'cc',
  "<cmd>lua vim.fn.inputsave(); local msg = vim.fn.input('Commit message: '); vim.fn.inputrestore(); vim.cmd('!git commit -m \"'..msg..'\"')<CR>",
  { desc = 'Commit with Message' }
)
vim.keymap.set('n', git_prefix .. 'ca', '<cmd>!git commit --amend<CR>', { desc = 'Amend Last Commit' })

-- Push submenu
vim.keymap.set('n', git_prefix .. 'pp', '<cmd>!git push<CR>', { desc = 'Push Current Branch' })
vim.keymap.set('n', git_prefix .. 'pf', '<cmd>!git push -f<CR>', { desc = 'Force Push' })

-- Pull submenu
vim.keymap.set('n', git_prefix .. 'lp', '<cmd>!git pull<CR>', { desc = 'Pull Current Branch' })
vim.keymap.set('n', git_prefix .. 'lr', '<cmd>!git pull --rebase<CR>', { desc = 'Pull with Rebase' })

-- Diff submenu
vim.keymap.set('n', git_prefix .. 'df', '<cmd>!git diff %<CR>', { desc = 'Diff Current File' })
vim.keymap.set('n', git_prefix .. 'da', '<cmd>!git diff<CR>', { desc = 'Diff All Files' })

-- Status
vim.keymap.set('n', git_prefix .. 'S', '<cmd>!git status<CR>', { desc = 'Status' })

-- Log submenu
vim.keymap.set('n', git_prefix .. 'Ll', '<cmd>!git log --oneline<CR>', { desc = 'Log Oneline' })
vim.keymap.set('n', git_prefix .. 'Lg', '<cmd>!git log --graph --decorate --oneline<CR>', { desc = 'Graph Log' })
vim.keymap.set('n', git_prefix .. 'Lp', '<cmd>!git log -p<CR>', { desc = 'Log with Patch' })

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
vim.keymap.set('n', git_prefix .. 'Cl', '<cmd>!git branch<CR>', { desc = 'List Branches' })

-- Stash submenu
vim.keymap.set('n', git_prefix .. 'ts', '<cmd>!git stash<CR>', { desc = 'Stash Changes' })
vim.keymap.set('n', git_prefix .. 'tp', '<cmd>!git stash pop<CR>', { desc = 'Pop Stash' })
vim.keymap.set('n', git_prefix .. 'tl', '<cmd>!git stash list<CR>', { desc = 'List Stashes' })
vim.keymap.set(
  'n',
  git_prefix .. 'td',
  "<cmd>lua vim.fn.inputsave(); local idx = vim.fn.input('Drop stash index: '); vim.fn.inputrestore(); vim.cmd('!git stash drop stash@{'..idx..'}')<CR>",
  { desc = 'Drop Stash' }
)

-- Reset submenu
vim.keymap.set('n', git_prefix .. 'rh', '<cmd>!git reset HEAD %<CR>', { desc = 'Reset Current File' })
vim.keymap.set('n', git_prefix .. 'ra', '<cmd>!git reset --hard<CR>', { desc = 'Reset All (Hard)' })

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
vim.keymap.set('n', git_prefix .. 'gl', '<cmd>!git tag<CR>', { desc = 'List Tags' })
vim.keymap.set(
  'n',
  git_prefix .. 'gd',
  "<cmd>lua vim.fn.inputsave(); local tag = vim.fn.input('Delete tag: '); vim.fn.inputrestore(); vim.cmd('!git tag -d '..tag)<CR>",
  { desc = 'Delete Tag' }
)
vim.keymap.set('n', git_prefix .. 'gp', '<cmd>!git push --tags<CR>', { desc = 'Push Tags' })
