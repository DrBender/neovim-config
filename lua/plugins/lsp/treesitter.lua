local ens_installed = {
    "bash",
    "c",
    "cpp",
    "cmake",
    "lua",
    "rust",
    "vim",
    "vimdoc",
    "python",
    "query",
    "html",
    "json",
    "toml",
    "xml",
    "yaml",
}
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        require("nvim-treesitter.install").compilers = { "clang", "gcc", "css" }
        -- Добавить ассоциацию файлов .qss с CSS парсером
        vim.filetype.add({
            extension = {
                qss = "css",
            },
        })
        config.setup({
            auto_install = true,
            ensure_installed = ens_installed,

            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
