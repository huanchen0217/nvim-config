return { -- LSP Config
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    { 'jose-elias-alvarez/null-ls.nvim', opts = {} },
  },
  config = function()
    ------------------------------------------
    local servers = {
      -- Systems Languages
      clangd = {}, -- C / C++
      lua_ls = {}, -- Lua
      marksman = {}, -- Markdown

      -- Full Stack / Web
      ['typescript-language-server'] = {}, -- TypeScript / JavaScript
      html = {}, -- HTML
      cssls = {}, -- CSS
      jsonls = {}, -- JSON

      -- Backend / Scripting / Other
      pyright = {}, -- Python
      phpactor = {}, -- PHP
      bashls = {}, -- Bash / shell
      dockerls = {}, -- Dockerfile
    }
    ------------------------------------------

    require('mason-tool-installer').setup { ensure_installed = vim.tbl_keys(servers) }
    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = true,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }

    -- ========================
    -- LSP Keymaps & Attach
    -- ========================
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Rename / Code Actions / References / Navigation
        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
        map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
        map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
        map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help', 'i')

        -- Formatting
        map('<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, 'Format Buffer')

        -- Format buffer on save
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = event.buf,
          callback = function()
            vim.lsp.buf.format { async = false }
          end,
        })

        -- Workspace folders
        map('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder')
        map('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder')
        map('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'List Workspace Folders')

        -- Diagnostics navigation
        map('[d', function()
          vim.diagnostic.navigate(-1)
        end, 'Prev Diagnostic')

        map(']d', function()
          vim.diagnostic.navigate(1)
        end, 'Next Diagnostic')

        map('[e', function()
          vim.diagnostic.navigate(-1, { severity = vim.diagnostic.severity.ERROR })
        end, 'Prev Error')

        map(']e', function()
          vim.diagnostic.navigate(1, { severity = vim.diagnostic.severity.ERROR })
        end, 'Next Error')

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client then
          if client.server_capabilities.documentHighlightProvider then
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

          if client.server_capabilities.inlayHintProvider then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end
      end,
    })

    -- ========================
    -- Diagnostics
    -- ========================
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

    -- ========================
    -- Null-LS Setup (Formatting)
    -- ========================
    local null_ls = require 'null-ls'
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua.with {
          command = vim.fn.stdpath 'data' .. '/mason/bin/stylua',
        },
      },
    }
  end,
}
