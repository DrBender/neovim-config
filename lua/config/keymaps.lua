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
vim.keymap.set("n", "<leader>h", ":ClangdSwitchSourceHeader<CR>", { desc = "Clang: Switch Source/Header" })
vim.keymap.set("n", "<leader>csi", ":ClangdSymbolInfo<CR>", { desc = "Symbol Info" })

vim.keymap.set("n", "<leader>cio", ":ClangdSetInlayHints<CR>", { desc = "Set Inlay Hints" })

vim.keymap.set("n", "<leader>cio", ":ClangdDisableInlayHints<CR>", { desc = "Disable Inlay Hints" })
vim.keymap.set("n", "<leader>cif", ":ClangdToggleInlayHints<CR>", { desc = "Toggle Inlay Hints" })
-- vim.api.

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format Code" })

vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "vim.diagnostic.open_float" })

vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })

-- Function for terminal floating window
local function float_term()
    -- vim.api.nvim_open_term(cmd or '', {
    --   direction = 'float',
    --   float_opts = {
    --     border = 'rounded',  -- рамка: 'single', 'rounded', 'double'
    --     width = math.floor(vim.o.columns * 0.8),
    --     height = math.floor(vim.o.lines * 0.8),
    --     row = math.floor(vim.o.lines * 0.1),
    --     col = math.floor(vim.o.columns * 0.1)
    --   }
    -- })
    local filename = vim.fn.expand('%:p')
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.7)

    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - height) / 2 - 1),
        style = 'minimal',
        border = 'single'
    })
    vim.fn.termopen('lua "' .. filename .. '"')
    -- vim.api.nvim_command('terminal lua %')
    -- vim.api.nvim_command('startinsert')
end

-- Клавиши
vim.keymap.set('n', '<leader>ml', function() float_term() end, { desc = 'Float Lua term' })
