return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = function()
        local conf = require("ibl.config")
        print(conf)
        return conf
    end,
    config = function(_, opts)
        local highlight = {
            "CursorColumn",
            "Whitespace",
            -- "Tabs",
        }
        local config = require("ibl.config")
        
        -- local highlight = {
        --     "RainbowDelimiterRed",
        --     "RainbowDelimiterYellow",
        --     "RainbowDelimiterBlue",
        --     "RainbowDelimiterOrange",
        --     "RainbowDelimiterGreen",
        --     "RainbowDelimiterViolet",
        --     "RainbowDelimiterCyan",
        -- }
        -- vim.g.rainbow_delimiters = { highlight = highlight }
        -- require("ibl").setup({ scope = { highlight = highlight } })
        --
        -- local hooks = require("ibl.hooks")
        -- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        -- require("ibl").setup(opts)
        require("ibl").setup(config)
        -- require("ibl").setup({
        -- use_treesitter = true,
        -- indent = { highlight = highlight, char = ""}, --"▎" },
        -- whitespace = {
        --     highlight = highlight,
        --     remove_blankline_trail = false,
        --  },
        -- })
    end,
}
