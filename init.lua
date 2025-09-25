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

-- Plugins
require('lazy').setup({
  'NMAC427/guess-indent.nvim',

  { -- Git signs
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Which-key
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  { -- Telescope
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
  },

  { -- Lazydev
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  { -- LSP Config
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            return diagnostic.message
          end,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, { 'stylua' })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Neoscroll
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup {
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing_function = 'linear',
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return { timeout_ms = 500, lsp_format = 'fallback' }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    opts = {
      keymap = { preset = 'default' },
      appearance = { nerd_font_variant = 'mono' },
      completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = { lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 } },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
    },
  },

  { -- Colorscheme
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        styles = { comments = { italic = false } },
        on_colors = function(colors)
          -- Define colors here
        end,
        on_highlights = function(highlights, colors)
          -- Define highlights here
        end,
      }
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  { -- Todo comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  { -- Mini plugins
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
    end,
  },

  { -- Treesitter
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 'bash', 'yaml', 'c', 'diff', 'html', 'lua', 'latex', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },

  {
    'yetone/avante.nvim',
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = vim.fn.has 'win32' ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' or 'make',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- add any opts here
      -- this file can contain specific instructions for your project
      mode = 'legacy',
      instructions_file = 'avante.md',
      -- for example
      provider = 'claude',
      providers = {
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-sonnet-4-20250514',
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20480,
          },
        },
        moonshot = {
          endpoint = 'https://api.moonshot.ai/v1',
          model = 'kimi-k2-0711-preview',
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 32768,
          },
        },
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'echasnovski/mini.pick', -- for file_selector provider mini.pick
      'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      'ibhagwan/fzf-lua', -- for file_selector provider fzf
      'stevearc/dressing.nvim', -- for input provider dressing
      'folke/snacks.nvim', -- for input provider snacks
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },

  { --Markdown Rendering in Nvim
    'MeanderingProgrammer/render-markdown.nvim',
    latex = true,
    --    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  { --Markdown Preview in Browser
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    ft = { 'markdown' },
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
      vim.keymap.set('n', '<leader>M', function()
        vim.cmd 'MarkdownPreviewToggle'
      end, { desc = 'Toggle Markdown Preview' })
    end,
  },

  { -- Image Rendering
    '3rd/image.nvim',
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      processor = 'magick_cli',
    },
  },

  { -- Obsidian
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
            path = '~/Library/Mobile Documents/com~apple~CloudDocs/Database/',
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
          ['gf'] = {
            action = function()
              return require('obsidian').util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          ['<leader>ch'] = {
            action = function()
              return require('obsidian').util.toggle_checkbox()
            end,
          },
        },
      }
    end,
  },

  { -- Autocompletion
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
  },

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