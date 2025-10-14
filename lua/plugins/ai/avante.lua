return {
  {
    "yetone/avante.nvim",
    lazy = false,
    build = vim.fn.has("win32") ~= 0
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
    version = false,
    opts = (function()
      local models = { "gemma3:12b", "gemma3:27b", "qwen3-coder:30b" }
      local opts = {
        instructions_file = "avante.md",
        provider = "ollama",
        providers = {
          ollama = {
            endpoint = "http://127.0.0.1:11434",
            model = "qwen3-coder:30b",
            timeout = 30000,

            -- temperature: controls randomness of token generation
            -- 0.0–0.3 → highly deterministic, best for reproducible code
            -- 0.4–0.7 → moderate randomness, allows alternative phrasing/variable names
            -- 0.8–1.0+ → high randomness, more exploratory outputs, risk of nonsense
            temperature = 0.3,

            -- threads: maximum CPU cores used for inference
            -- lower → smoother battery usage, less spiky power, slightly slower
            -- higher → faster generation, higher peak power, more battery drain
            threads = 6,

            -- batch_size: number of tokens processed per generation step
            -- smaller → smoother inference, reduced memory/bandwidth spikes
            -- larger → faster throughput, potentially spikier CPU/GPU load
            batch_size = 4,
          },
        },
        behaviour = {
          enable_fastapply = false,
        },
      }

      -- Model switch function
      function opts.switch_model()
        print("Select model:")
        for i, m in ipairs(models) do
          print(i .. ": " .. m)
        end
        local choice = tonumber(vim.fn.input("Enter model number: "))
        if choice and models[choice] then
          opts.providers.ollama.model = models[choice]
          print("Switched Avante to " .. models[choice])
        else
          print("Invalid choice")
        end
      end

      -- Keymap inside opts so it runs on plugin setup
      vim.api.nvim_set_keymap(
        "n",
        "<leader>am",
        "<cmd>lua require('avante').opts.switch_model()<CR>",
        { noremap = true, silent = true }
      )

      return opts
    end)(),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
      "stevearc/dressing.nvim",
      "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
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
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
