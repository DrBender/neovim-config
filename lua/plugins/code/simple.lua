return {
    -- { "solvedbiscuit71/vim-autopair" },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    { "powerman/vim-plugin-ruscmd" },
    { "nvim-tree/nvim-web-devicons", opts = {} },
    {
        -- LSP renaming
        "smjonas/inc-rename.nvim",
        opts = {},
        config = function()
            require("inc_rename").setup({
                input_buffer_type = "snacks",
            })
            -- vim.keymap.set("n", "<leader>rn", ":IncRename ", {desc= "Rename"})
            vim.keymap.set("n", "<leader>rn", function()
                return ":IncRename " .. vim.fn.expand("<cword>")
            end, { expr = true, desc = "Rename ..." })
        end,
    },
}
