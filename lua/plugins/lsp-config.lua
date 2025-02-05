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
                ensure_installed = { "lua_ls", "clangd", "cmake", "jsonls", "bashls" },
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
    {
        -- Quickstart configurations for the Nvim LSP client
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            require("lazydev").setup({})
            local lspconfig = require("lspconfig")
            ------------ LUA_LS ---------------
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                        telemetry = { enable = false },
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                            special = {
                                reload = "require",
                            },
                            -- path = vim.split(package.path, ";"),
                        },
                        diagnostics = {
                            globals = { "vim", "pvim" },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files and plugins
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },

                            checkThirdParty = false,
                        },
                    },
                },
            })
            ------------ CLANGD ---------------
            lspconfig.clangd.setup({

                -- on_attach = function (client, bufnr)
                --     client.server_capabilities.signatureHelpProvider = false
                --     on_attach(client, bufnr)
                -- end,
                capabilities = capabilities,
            })
            lspconfig.cmake.setup({
                capabilities = capabilities,
            })
            lspconfig.jsonls.setup({
                capabilities = capabilities,
            })
            lspconfig.bashls.setup({
                capabilities = capabilities,
                cmd = { "bash-language-server", "start" },
            })
            -- require("clangd_extensions.inlay_hints").setup_autocmd()
            -- require("clangd_extensions.inlay_hints").set_inlay_hints()
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
            -- vim.keymap.set("n", "<leader>h", ":ClangdSwitchSourceHeader<CR>", {})
            vim.keymap.set("n", "<C-Tab>", ":ClangdSwitchSourceHeader<CR>", {})

            vim.keymap.set("n", "<leader>gsi", ":ClangdSymbolInfo<CR>", { desc = "Symbol Info" })

            vim.keymap.set("n", "<leader>cio", ":ClangdSetInlayHints<CR>", { desc = "Set Inlay Hints" })

            vim.keymap.set("n", "<leader>cio", ":ClangdDisableInlayHints<CR>", { desc = "Disable Inlay Hints" })
            vim.keymap.set("n", "<leader>cif", ":ClangdToggleInlayHints<CR>", { desc = "Toggle Inlay Hints" })
            -- vim.api.
        end,
    },
}
