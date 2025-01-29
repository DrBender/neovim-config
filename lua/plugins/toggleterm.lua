return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            -- direction = "float",
            -- 'vertical' | 'horizontal' | 'tab' | 'float'
            direction = "horizontal",
            -- float_opts = {},
            display_name = "work",
            close_on_exit = true,
            open_mapping = "<leader>t",
            insert_mappings = true,
            shade_terminals = true,
            winbar = {
                enabled = true,
                name_formatter = function(term)
                    return term.name
                end,
            },
        })
        -- command! -count=1 TermGitPush  lua require'toggleterm'.exec("git push",    <count>, 12)
        -- command! -count=1 TermGitPushF lua require'toggleterm'.exec("git push -f", <count>, 12)
    end,
}
