-- store original notify function
local orig_notify = vim.notify
local last_avante_msg = nil

-- override notify
vim.notify = function(msg, level, opts)
  if msg:match("Using previously selected model") then
    last_avante_msg = msg  -- store it
    return  -- suppress
  end
  return orig_notify(msg, level, opts)
end

-- function to show or choose the Avante message
function AvanteShowChoose()
  if last_avante_msg then
    -- simple choice: just show it
    local choice = vim.fn.input("Show Avante message? [y/N]: ")
    if choice:lower() == "y" then
      orig_notify(last_avante_msg, vim.log.levels.INFO, {})
    end
  else
    orig_notify("No Avante message stored.", vim.log.levels.WARN, {})
  end
end
