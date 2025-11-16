return {
    -- different plugins for colorizers and color-pickers
    {
        -- https://github.com/catgoose/nvim-colorizer.lua
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = {},
    },
    {
        -- https://github.com/rachartier/tiny-devicons-auto-colors.nvim
        "rachartier/tiny-devicons-auto-colors.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        event = "VeryLazy",
        config = function()
            require("tiny-devicons-auto-colors").setup()
        end,
    },
    {
        "uga-rosa/ccc.nvim",
        config = function()
            local ccc = require("ccc")
            local mapping = ccc.mapping

            ccc.setup({
                -- Your preferred settings
                -- Example: enable highlighter
                highlighter = {
                    auto_enable = true,
                    lsp = true,
                },
            })
        end,
    },
    { "nvzone/volt", lazy = true },
    -- https://github.com/xzbdmw/colorful-menu.nvim
    {
        -- https://github.com/nvzone/minty
        "nvzone/minty",
        cmd = { "Shades", "Huefy" },
    },
}
