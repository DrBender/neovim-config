-- LSP
return {
    {
        -- Easily install and manage LSP servers, DAP servers, linters, and formatters
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_pending = " ",
                        package_installed = "󰄳 ",
                        package_uninstalled = " 󰚌",
                    },
                },
            })
        end,
    },
}
