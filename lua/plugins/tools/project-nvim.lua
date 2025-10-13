return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      manual_mode = false,               -- auto-detect project root
      detection_methods = { "pattern" }, -- look for .git, package.json, etc.
      patterns = { ".git", "package.json", "pyproject.toml", "Makefile" },
      show_hidden = true,
    })

    -- Integrate with Telescope
    require("telescope").load_extension("projects")

    -- Keymap to open projects
    vim.keymap.set(
      "n",
      "<leader>sp",
      "<cmd>Telescope projects<cr>",
      { desc = "[S]earch [P]rojects" }
    )
  end,
}
