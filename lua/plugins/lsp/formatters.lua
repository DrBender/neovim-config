return {
    -- Установите через менеджер плагинов (lazy.nvim)
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                cpp = { "clang_format", "astyle" }, -- ← Добавлено для C++
                c = { "clang_format", "astyle" }, -- ← И для C
                -- javascript = { { "prettierd", "prettier" } },
                -- typescript = { { "prettierd", "prettier" } },
                -- python = { "isort", "black" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true, -- Если LSP тоже умеет форматировать, использует его как запасной вариант
            },
            clang_format = {
                command = "clang-format",
                args = { "-style=file" }, -- Будет использовать .clang-format файл в проекте
            },
        },
    },
}
