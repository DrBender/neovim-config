print("Formatters")
return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                cpp = { "clang_format" },
                c = { "clang_format" },
                -- python = { "isort", "black" },
            },
            -- format_on_save = {
            --     timeout_ms = 500,
            --     lsp_fallback = true, -- Uses LSP as backup plan for formatting
            -- },
            clang_format = {
                command = "clang-format",
                args = { "-style=file" }, -- Use .clang-format file in project directory
            },
        },
    },
}
