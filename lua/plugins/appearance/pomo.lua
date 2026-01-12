-- ~/.config/nvim/lua/plugins/pomo.lua
return {
    "epwalsh/pomo.nvim",
    version = "*",
    lazy = true, -- load immediately so commands and keymaps work
    dependencies = { "rcarriga/nvim-notify" },
    config = function()
        local pomo = require("pomo")

        -- Setup pomo.nvim
        pomo.setup({
            update_interval = 1000,
            notifiers = {
                {
                    name = "Default",
                    opts = {
                        sticky = true,
                        title_icon = "⏳",
                        text_icon = "⏱️",
                    },
                },
                { name = "System" },
            },
            timers = {
                Break = { { name = "System" } },
            },
            sessions = {
                pomodoro = {
                    { name = "Work",        duration = "25m" },
                    { name = "Short Break", duration = "5m" },
                    { name = "Work",        duration = "25m" },
                    { name = "Short Break", duration = "5m" },
                    { name = "Work",        duration = "25m" },
                    { name = "Long Break",  duration = "15m" },
                },
            },
        })

        -- === KEYMAPS ===

        -- Start a single timer
        vim.keymap.set("n", "<leader>pt", function()
            local duration = vim.fn.input("Timer duration (e.g., 25m, 10s, 1h30m): ")
            if duration == "" then return end
            local name = vim.fn.input("Timer name (optional): ")
            local cmd = ":TimerStart " .. duration
            if name ~= "" then cmd = cmd .. " " .. name end
            vim.cmd(cmd)
        end, { desc = "Create [T]imer", noremap = true, silent = true })

        -- Start a repeat timer
        vim.keymap.set("n", "<leader>pe", function()
            local duration = vim.fn.input("Repeat timer duration (e.g., 10s): ")
            if duration == "" then return end
            local reps = vim.fn.input("Repetitions: ")
            if reps == "" then return end
            local name = vim.fn.input("Timer name (optional): ")
            local cmd = ":TimerRepeat " .. duration .. " " .. reps
            if name ~= "" then cmd = cmd .. " " .. name end
            vim.cmd(cmd)
        end, { desc = "Start R[e]peat Timer", noremap = true, silent = true })

        -- Start a session
        vim.keymap.set("n", "<leader>ps", function()
            local session = vim.fn.input("Session name: ")
            if session == "" then return end
            vim.cmd(":TimerSession " .. session)
        end, { desc = "Start session", noremap = true, silent = true })

        -- Pause/Resume/Stop/Hide/Show timers
        local function prompt_cmd(command)
            return function()
                local id = vim.fn.input("Timer ID (or -1 for all, leave empty for latest): ")
                if id == "" then
                    vim.cmd(":" .. command)
                else
                    vim.cmd(":" .. command .. " " .. id)
                end
            end
        end

        -- Cancel/exit
        vim.keymap.set('n', '<leader>pc', function() end,
            { desc = '[C]ancel', noremap = true, silent = true })

        vim.keymap.set("n", "<leader>pp", prompt_cmd("TimerPause"),
            { desc = "[P]ause timer", noremap = true, silent = true })
        vim.keymap.set("n", "<leader>pr", prompt_cmd("TimerResume"),
            { desc = "[R]esume timer", noremap = true, silent = true })
        vim.keymap.set("n", "<leader>px", prompt_cmd("TimerStop"), { desc = "Stop timer", noremap = true, silent = true })

        vim.keymap.set("n", "<leader>ph", prompt_cmd("TimerHide"), { desc = "[H]ide timer", noremap = true, silent = true })
        vim.keymap.set("n", "<leader>ps", prompt_cmd("TimerShow"), { desc = "[S]how timer", noremap = true, silent = true })
    end,
}
