return {
    -- DiffView (diff-files viewer)
    {
        "sindrets/diffview.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    },
    -- {
    --     "tpope/vim-fugitive",
    -- },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
            vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Git Preview Hunk" })
            vim.keymap.set(
                "n",
                "<leader>gt",
                ":Gitsigns toggle_current_line_blame<CR>",
                { desc = "Git toggle line blame" }
            )
        end,
    },
}
