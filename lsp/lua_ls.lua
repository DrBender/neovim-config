-- Config lua_ls
return {
    cmd = { "lua-language-server" }, -- lua-language-server should be in PATH
    filetypes = { "lua" },           -- file associations
    root_markers = {
        ".git",
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
    }, -- markers for projects root
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",                  -- use LuaJIT
                path = vim.split(package.path, ";"), -- Lua modules path
            },
            diagnostics = {
                globals = { "vim" }, -- define global varialbles for diagnostics
            },
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"), -- библиотека runtime Neovim, чтобы подсказать стандартные lua модули
                    vim.fn.stdpath("config"),         -- user configuration
                },
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
    on_attach = function(client, bufnr)
        -- Отключаем встроенное форматирование lua_ls (если планируется форматировать через null-ls)
        -- client.server_capabilities.documentFormattingProvider = false
    end,
}
