-- ~/.config/nvim/lua/plugins/notify.lua
return {
  "rcarriga/nvim-notify",
  lazy = true,
  config = function()
    local notify = require("notify")

    notify.setup({
      -- Render style controls the appearance of the notification window.
      -- Options:
      -- "default"         : standard notification layout (lines wrapped, padding added)
      -- "minimal"         : very basic layout with minimal formatting
      -- "simple"          : simple layout with basic formatting
      -- "compact"         : compact layout, no padding, lines may be truncated
      -- "wrapped-compact" : like compact but wraps lines to max_width
      -- "wrapped-default" : like default but wraps lines to max_width
      render = "default",

      -- Animation style controls how notifications appear/disappear.
      -- Options:
      -- "fade"              : fade in/out smoothly
      -- "fade_in_slide_out" : fade in, slide out when closing
      -- "slide"             : slide in/out horizontally or vertically
      -- "static"            : no animation, just pop in/out
      stages = "fade",

      timeout = 5000,           -- milliseconds before notification auto-closes
      background_colour = "#000000",
      merge_duplicates = true,  -- merge notifications with the same text into one

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
  end,
}
