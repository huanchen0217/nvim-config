return { --Markdown Preview in Browser
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && yarn install',
  ft = { 'markdown' },
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
    vim.keymap.set('n', '<leader>tm', function()
      vim.cmd 'MarkdownPreviewToggle'
    end, { desc = 'Toggle [M]arkdown Preview' })
  end,
}
