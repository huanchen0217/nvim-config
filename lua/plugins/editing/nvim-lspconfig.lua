return { -- LSP Config
  'neovim/nvim-lspconfig',
  event = 'BufReadPre',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    -- LSP servers
    local servers = {
      clangd = {}, -- C / C++
      lua_ls = {}, -- Lua
      marksman = {}, -- Markdown
      ['typescript-language-server'] = {}, -- TypeScript / JavaScript
      html = {}, -- HTML
      cssls = {}, -- CSS
      jsonls = {}, -- JSON
      pyright = {}, -- Python
      phpactor = {}, -- PHP
      bashls = {}, -- Bash / shell
      dockerls = {}, -- Dockerfile
    }

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

    -- LSP attach & keymaps
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Rename / Code Actions / Navigation
        map('grn', vim.lsp.buf.rename, 'Rename')
        map('gra', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
        map('grr', require('telescope.builtin').lsp_references, 'References')
        map('gri', require('telescope.builtin').lsp_implementations, 'Implementation')
        map('grd', require('telescope.builtin').lsp_definitions, 'Definition')
        map('grD', vim.lsp.buf.declaration, 'Declaration')
        map('gO', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
        map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
        map('grt', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
        map('K', vim.lsp.buf.hover, 'Hover')
        map('<C-k>', vim.lsp.buf.signature_help, 'Signature', 'i')

        -- Formatting: leader f
        map('<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, '[F]ormat Buffer')

        -- Workspace folders
        map('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder')
        map('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder')
        map('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'List Workspace Folders')

        -- Diagnostics navigation
        map('[d', function() vim.diagnostic.navigate(-1) end, 'Prev Diagnostic')
        map(']d', function() vim.diagnostic.navigate(1) end, 'Next Diagnostic')
        map('[e', function() vim.diagnostic.navigate(-1, { severity = vim.diagnostic.severity.ERROR }) end, 'Prev Error')
        map(']e', function() vim.diagnostic.navigate(1, { severity = vim.diagnostic.severity.ERROR }) end, 'Next Error')

        -- Document highlight
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local hl_group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = hl_group,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = hl_group,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(ev)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = ev.buf }
            end,
          })
        end
      end,
    })

    -- Diagnostics display
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
  end,
}
