return {
    "mfussenegger/nvim-lint",
    opts = {
        linters_by_ft = {
            -- lua = { "selene", "luacheck" },
            lua = { "luacheck" },
            cpp = { "cpplint", "cppcheck", "clang-tidy" }, -- ← Добавлено для C++
            c = { "cppcheck", "clang-tidy" }, -- ← И для C
        },
        linters = {
            selene = {
                condition = function(ctx)
                    local root = LazyVim.root.get({ normalize = true })
                    if root ~= vim.uv.cwd() then
                        return false
                    end
                    return vim.fs.find({ "selene.toml" }, { path = root, upward = true })[1]
                end,
            },
            luacheck = {
                condition = function(ctx)
                    local root = LazyVim.root.get({ normalize = true })
                    if root ~= vim.uv.cwd() then
                        return false
                    end
                    return vim.fs.find({ ".luacheckrc" }, { path = root, upward = true })[1]
                end,
            },
            -- cppcheck = {
            --     command = "cppcheck",
            --     args = {
            --         "--enable=warning,style,performance,portability",
            --         "--language=c++",
            --         "--template=gcc",
            --         "--inline-suppr",
            --         "--quiet",
            --         "$FILENAME",
            --     },
            -- },
            -- clang_tidy = {
            --     command = "clang-tidy",
            --     args = {
            --         "--quiet",
            --         "$FILENAME",
            --     },
            -- },
            cpplint = {
                command = "cpplint",
                args = {
                    "--filter=-whitespace,-legal/copyright",
                    "$FILENAME",
                },
            },
        },
    },
    config = function()
        local lint = require("lint")
    end,
}
