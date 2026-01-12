return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")

    notify.setup({
      render = "default",
      stages = "fade",
      timeout = 5000,
      background_colour = "#000000",
      merge_duplicates = true,
      icons = {
        ERROR = "",
        WARN  = "",
        INFO  = "",
        DEBUG = "",
        TRACE = "✎",
      },
    })

    -- Set nvim-notify as the default notification handler
    vim.notify = notify

    -- Keymap to dismiss all notifications
    vim.keymap.set("n", "<leader>tN", function()
      notify.dismiss()
    end, { desc = "Dismiss all notifications" })
  end,
}
