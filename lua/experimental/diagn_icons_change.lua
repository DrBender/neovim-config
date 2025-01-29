print("Experimental/diagnostics.lua")

local icons_d = require("customs.icons").diagnostics
print(icons_d)
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons_d.BoldError,
            [vim.diagnostic.severity.WARN] = icons_d.BoldWarning,
            [vim.diagnostic.severity.INFO] = icons_d.BoldInformation,
            [vim.diagnostic.severity.HINT] = icons_d.BoldHint,
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",

            -- [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",

            -- [vim.diagnostic.severity.INFO] = "InformationMsg",
            -- [vim.diagnostic.severity.HINT] = "HintMsg",
        },
    },
    virtual_text = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        -- source = "always",
        source = true,
        header = "",
        prefix = "",
    },
})
