-- store original notify function
local orig_notify = vim.notify
local last_avante_msg = nil

-- override notify
vim.notify = function(msg, level, opts)
  if msg:match("Using previously selected model") then
    last_avante_msg = msg  -- store silently
    return  -- suppress display
  end
  return orig_notify(msg, level, opts)
end

-- function to immediately show the stored Avante message
function WhichAvante()
  if last_avante_msg then
    orig_notify(last_avante_msg, vim.log.levels.INFO, {})
  else
    orig_notify("No Avante message stored.", vim.log.levels.WARN, {})
  end
end
