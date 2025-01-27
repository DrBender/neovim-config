return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = function()
        local conf = require("ibl.config")

        return conf 
    end,
    config = function(_, opts)
        local highlight = {
            "CursorColumn",
            "Whitespace",
        }
        require("ibl").setup(opts)
       -- require("ibl").setup({
         --   indent = { highlight = highlight, char = "▎" },
           -- whitespace = {
            --    highlight = highlight,
              --  remove_blankline_trail = false,
            --},
        --})
    end,
}
