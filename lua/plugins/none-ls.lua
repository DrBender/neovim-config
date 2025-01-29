return {
    -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
    "nvimtools/none-ls.nvim",
    priority = 200,
    config = function()
        local null_ls = require("null-ls")

        local no_fucks = {
            method = null_ls.methods.DIAGNOSTICS,
            filetypes = { "markdown", "text", "lua" },
            generator = {
                fn = function(params)
                    local diagnostics = {}
                    -- sources have access to a params object
                    -- containing info about the current file and editor state
                    for i, line in ipairs(params.content) do
                        local col, end_col = line:find("fuck")
                        if col and end_col then
                            -- null-ls fills in undefined positions
                            -- and converts source diagnostics into the required format
                            table.insert(diagnostics, {
                                row = i,
                                col = col,
                                end_col = end_col + 1,
                                source = "no-fucks",
                                message = "Don't use 'fuck!'",
                                severity = vim.diagnostic.severity.WARN,
                            })
                        end
                    end
                    return diagnostics
                end,
            },
        }

        null_ls.register(no_fucks)

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.diagnostics.selene,
                -- null_ls.builtins.diagnostics.lua_ls,
                -- null_ls.builtins.formatting.clang_format,
                -- null_ls.builtins.diagnostics.cppcheck,
                -- null_ls.builtins.diagnostics.cmake_lint,
                -- null_ls.builtins.formatting.cmake_format,
                -- null_ls.builtins.formatting.astyle,
                -- null_ls.builtins.formatting.uncrustify,
                -- null_ls.builtins.diagnostics.shellcheck,
                -- null_ls.builtins.formatting.beautysh,
                -- null_ls.builtins.formatting.shfmt,
            },
        })

        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format Code" })
    end,
}
