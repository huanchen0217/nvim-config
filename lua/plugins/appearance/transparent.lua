return {
    "xiyaowong/transparent.nvim",
    config = function()
        require("transparent").setup({
            groups = {
                "Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier",
                "Statement", "PreProc", "Type", "Underlined", "Todo", "String", "Function",
                "Conditional", "Repeat", "Operator", "Structure", "LineNr", "NonText",
                "SignColumn", "CursorLine", "CursorLineNr", "StatusLine", "StatusLineNC",
                "EndOfBuffer",
            },
            extra_groups = {},       -- add plugin-specific groups here
            exclude_groups = {},     -- groups you don’t want cleared
            on_clear = function() end,
        })
    end,
}
