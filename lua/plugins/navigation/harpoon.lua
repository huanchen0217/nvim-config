return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },

  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })

    local list = function() return harpoon:list() end
    local ui = harpoon.ui

    -- ── CORE ─────────────────────────────────────────────
    vim.keymap.set("n", "<leader>ha", function() list():add() end, { desc = "Harpoon add file" })
    vim.keymap.set("n", "<leader>hh", function() ui:toggle_quick_menu(list()) end, { desc = "Harpoon quick menu" })

    -- ── MOVEMENT ─────────────────────────────────────────
    vim.keymap.set("n", "[h", function() list():prev() end, { desc = "Harpoon previous" })
    vim.keymap.set("n", "]h", function() list():next() end, { desc = "Harpoon next" })

    -- ── DIRECT SLOT JUMPS ────────────────────────────────
    vim.keymap.set("n", "<leader>h1", function() list():select(1) end, { desc = "Harpoon file 1" })
    vim.keymap.set("n", "<leader>h2", function() list():select(2) end, { desc = "Harpoon file 2" })
    vim.keymap.set("n", "<leader>h3", function() list():select(3) end, { desc = "Harpoon file 3" })
    vim.keymap.set("n", "<leader>h4", function() list():select(4) end, { desc = "Harpoon file 4" })

    -- ── TELESCOPE INTEGRATION ────────────────────────────
    local conf = require("telescope.config").values
    local function telescope_menu(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon Files",
        finder = require("telescope.finders").new_table({ results = file_paths }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    vim.keymap.set("n", "<leader>ht", function()
      telescope_menu(list())
    end, { desc = "Harpoon telescope menu" })

    -- ── SPLIT / TAB OPENING ──────────────────────────────
    harpoon:extend({
      UI_CREATE = function(cx)
        vim.keymap.set("n", "sv", function()
          ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr, desc = "Open in vertical split" })

        vim.keymap.set("n", "sh", function()
          ui:select_menu_item({ split = true })
        end, { buffer = cx.bufnr, desc = "Open in horizontal split" })

        vim.keymap.set("n", "st", function()
          ui:select_menu_item({ tabedit = true })
        end, { buffer = cx.bufnr, desc = "Open in new tab" })
      end,
    })
  end,
}
