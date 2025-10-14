return {
  {
    'yetone/avante.nvim',
    lazy = false,
    build = vim.fn.has 'win32' ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' or 'make',
    version = false,
    opts = {
      instructions_file = 'avante.md',
      provider = 'ollama',
      providers = {
        ollama = {
          endpoint = 'http://localhost:11434', -- official local endpoint
          model = 'gemma3:12b',
          timeout = 120000,
          stream = true,
          reuse = true,
          temperature = 0.3,
          threads = 6,
          batch_size = 4,
        },
      },
      behaviour = {
        enable_fastapply = false,
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
      'ibhagwan/fzf-lua',
      'stevearc/dressing.nvim',
      'folke/snacks.nvim',
      'nvim-tree/nvim-web-devicons',
      {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = { file_types = { 'markdown', 'Avante' } },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
}
