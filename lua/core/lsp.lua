print("LSP config")
vim.lsp.enable({
    "lua_ls",
    "clangd",
})
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
--
-- vim.lsp.config("*", {
--   capabilities = capabilities,
--   root_markers = { ".git", "." },
-- })

vim.diagnostic.config({
    -- virtual_lines = true,
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
        header = "header",
        prefix = "pre:",
    },

    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})
