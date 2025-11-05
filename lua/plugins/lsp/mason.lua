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
    {
        -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "cmake",
                    "jsonls",
                    "bashls",
                },
            })
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
