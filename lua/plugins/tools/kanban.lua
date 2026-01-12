return {
  "arakkkkk/kanban.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  cmd = { "KanbanCreate", "KanbanOpen" },  -- lazy-load only when these are used
  config = function()
    local ok, kanban = pcall(require, "kanban")
    if not ok then
      vim.notify("kanban.nvim failed to load", vim.log.levels.ERROR)
      return
    end

    kanban.setup({
      markdown = {
        description_folder = vim.fn.stdpath("data") .. "/kanban_tasks/",
        list_head = "## ",
      },
    })

    local ok_cmp, cmp_mod = pcall(require, "kanban.fn.cmp.nvim-cmp")
    if ok_cmp then
      cmp_mod.setup(kanban)
    end
  end,
}
