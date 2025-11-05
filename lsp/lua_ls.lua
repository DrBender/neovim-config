-- Определяем конфигурацию lua_ls
return {
    cmd = { "lua-language-server" }, -- путь к lua-language-server, убедитесь что он в PATH
    filetypes = { "lua" },           -- ассоциируем с lua файлами
    root_markers = {
        ".git",
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
    }, -- маркеры корня проекта
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",                  -- используем LuaJIT, как в Neovim
                path = vim.split(package.path, ";"), -- путь к Lua модулям
            },
            diagnostics = {
                globals = { "vim" }, -- определяем глобальную переменную vim для диагностики
            },
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"), -- библиотека runtime Neovim, чтобы подсказать стандартные lua модули
                    vim.fn.stdpath("config"),         -- конфигурация пользователя
                },
                checkThirdParty = false,
            },
            telemetry = { enable = false }, -- отключаем телеметрию
        },
    },
    on_attach = function(client, bufnr)
        -- Отключаем встроенное форматирование lua_ls (если планируется форматировать через null-ls)
        client.server_capabilities.documentFormattingProvider = false
    end,
}
