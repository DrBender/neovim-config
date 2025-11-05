return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            -- vim.keymap.set('n', '<C-p>', builtin.find_files, {})
            -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc="Live Grep"})
            -- for live_grep you need to install "sudo apt install ripgrep"
            require("telescope").load_extension("projects")
            require("telescope").setup({
                defaults = {
                    prompt_prefix = P_vim.icons.ui.Telescope .. " ",
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                        "--glob=!.git/",
                    },
                },
                color_devicons = true,
                file_ignore_patterns = { "^build/", "build/", "/build/", "/target/", "target/" },
            })
        end,
        event = "VimEnter",
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup({

                detection_methods = { "pattern" },
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
                datapath = vim.fn.stdpath("data"),
            })
        end,
        enabled = true,
        event = "VimEnter",
        cmd = "Telescope projects",
    },
}
