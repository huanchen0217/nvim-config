-- Capture and silence Avante's startup message
_G.avante_message = nil

-- Intercept writes to :echom and vim.notify
local old_notify = vim.notify
vim.notify = function(msg, level, opts)
  if type(msg) == "string" and msg:match("Using previously selected model:") then
    _G.avante_message = msg
    return -- suppress display
  end
  return old_notify(msg, level, opts)
end

-- Function to show the stored message later
function _G.whichAvante()
  if _G.avante_message then
    vim.notify(_G.avante_message, vim.log.levels.INFO)
  else
    vim.notify("No Avante message captured.", vim.log.levels.WARN)
  end
end
