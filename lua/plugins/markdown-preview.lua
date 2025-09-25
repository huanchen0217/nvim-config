return { --Markdown Preview in Browser
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
}
