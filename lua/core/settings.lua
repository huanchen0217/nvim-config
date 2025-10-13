-- Basic settings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.g.mkdp_echo_preview_url = 1

-- Editor UI
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.mousehide = true
vim.o.showmode = false
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.scrolloff = 10

-- Behavior
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.inccommand = 'split'
vim.o.confirm = true

-- Indentation & formatting
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.shortmess:append("I")  -- suppress intro message
