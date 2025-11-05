return {
    "folke/which-key.nvim",
    enabled = true,
    opts = {
        preset = "helix",
        debug = vim.uv.cwd():find("which%-key"),
        win = {},
        spec = {},
    },
}
