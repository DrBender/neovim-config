-- return {
-- 	"catppuccin/nvim",
-- 	lazy = false,
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("catppuccin-frappe")
-- 	end,
-- }

return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        vim.cmd.colorscheme("tokyonight-moon")
        -- vim.cmd.colorscheme("tokyonight-night")
        -- vim.cmd.colorscheme("tokyonight-storm")
        -- vim.cmd.colorscheme("tokyonight-day")
    end,
}


-- lua/plugins/rose-pine.lua
-- return {
--     "rose-pine/neovim",
--     name = "rose-pine",
--     config = function()
--         vim.cmd("colorscheme rose-pine")
--     end,
-- }
