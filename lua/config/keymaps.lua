function SaveAndExit()
    -- wirte all buffers first
    vim.api.nvim_command(":wa")
    -- quit all buffers
    vim.api.nvim_command(":qa")
end
function Save()
    vim.api.nvim_command(":w")
end

vim.api.nvim_set_keymap(
    "n",
    "<leader>q",
    "<cmd>lua SaveAndExit()<CR>",
    { desc = "QUIT", noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>lua Save()<CR>", { desc = "Save", noremap = true, silent = true })

--- Telescope
-- vim.api.nvim_set_keymap("n", "<leader>d[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>d]", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap(
    "n",
    "<leader>ff",
    "<cmd>Telescope find_files<cr>",
    { desc = "Find File", noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>fg",
    "<cmd>Telescope live_grep<cr>",
    { desc = "Live Grep", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>fb",
    "<cmd>Telescope buffers<cr>",
    { desc = "Find Buffer", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>fh",
    "<cmd>Telescope help_tags<cr>",
    { desc = "Help Tags", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>fs",
    "<cmd>Telescope grep_string<cr>",
    { desc = "Search String", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>fc",
    "<cmd>Telescope commands<cr>",
    { desc = "Commands", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>fp",
    "<cmd>Telescope projects<cr>",
    { desc = "Projects", noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>fn",
    "<cmd>Telescope notify<cr>",
    { desc = "Notify", noremap = true, silent = true }
)

----- LSP

vim.api.nvim_set_keymap(
    "n",
    "<leader>la",
    "<cmd>lua vim.lsp.buf.code_action()<cr>",
    { desc = "Code Action", noremap = true, silent = true }
)

-- require("clangd_extensions.inlay_hints").setup_autocmd()
-- require("clangd_extensions.inlay_hints").set_inlay_hints()
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
-- vim.keymap.set("n", "<leader>h", ":ClangdSwitchSourceHeader<CR>", {})
-- vim.keymap.set("n", "<C-Tab>", ":ClangdSwitchSourceHeader<CR>", { desc = "Clang: Switch Source/Header" })
vim.keymap.set("n", "<leader>h", ":ClangdSwitchSourceHeader<CR>", { desc = "Clang: Switch Source/Header" })
vim.keymap.set("n", "<leader>gsi", ":ClangdSymbolInfo<CR>", { desc = "Symbol Info" })

vim.keymap.set("n", "<leader>cio", ":ClangdSetInlayHints<CR>", { desc = "Set Inlay Hints" })

vim.keymap.set("n", "<leader>cio", ":ClangdDisableInlayHints<CR>", { desc = "Disable Inlay Hints" })
vim.keymap.set("n", "<leader>cif", ":ClangdToggleInlayHints<CR>", { desc = "Toggle Inlay Hints" })
-- vim.api.

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format Code" })
