return {
    -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
    "nvimtools/none-ls.nvim",
    priority = 200,
    config = function()
        local null_ls = require("null-ls")

        -- local no_fucks = require("diag.no_fucks")

        -- null_ls.register(no_fucks)

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                -- null_ls.builtins.diagnostics.selene,
                null_ls.builtins.diagnostics.luacheck,
                null_ls.builtins.diagnostics.clang_tidy,
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
    end,
}
