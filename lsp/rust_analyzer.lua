-- Config rust_analyzer
print("TEst")
return {
    cmd = { "rust-analyzer" }, -- rust-analyzer should be in PATH
    filetypes = { "rust" },      -- file associations
    root_markers = {
        ".git",
    }, -- markers for projects root
    -- settings = {
    --     ["rust-analyzer"] = {
    --         cargo = { buildScripts = { enable = true } },
    --         procMacro = { enable = true },
    --         -- Включение inlay hints (подсказки типов прямо в коде)
    --         inlayHints = {
    --             bindingModeHints = { enable = true },
    --             chainingHints = { enable = true },
    --             closingBraceHints = { enable = true },
    --         },
    --     },
    -- },
    -- on_attach = function(client, bufnr)
    --     -- Отключаем встроенное форматирование lua_ls (если планируется форматировать через null-ls)
    --     -- client.server_capabilities.documentFormattingProvider = false
    -- end,
}
