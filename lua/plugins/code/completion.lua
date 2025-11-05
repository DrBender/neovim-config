return {
    {
        -- nvim-cmp source for neovim builtin LSP client
        "hrsh7th/cmp-nvim-lsp",
    },
    {
        -- Snippet Engine for Neovim written in Lua.
        "L3MON4D3/LuaSnip",
        dependencies = {
            -- luasnip completion source for nvim-cmp
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets", -- snippets
        },
    },
    {
        -- A completion plugin for neovim coded in Lua.
        "hrsh7th/nvim-cmp",
        config = function()
            require("core.completions").setup()
        end,

        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            dependencies = {
                "L3MON4D3/LuaSnip",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-emoji",
                "chrisgrieser/cmp-nerdfont",
                "ray-x/cmp-treesitter",
                "saadparwaiz1/cmp_luasnip",
                "roobert/tailwindcss-colorizer-cmp.nvim",
                "Exafunction/codeium.nvim",
            },
        },
    },
}
