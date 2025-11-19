local my_opts = {
    title = "🎯 CMake Presets",
    prompt = "Select preset:",
    border = "rounded",
    width = 1,
    items = {
        { text = "Option 1", value = "a", count = 1, icon = "🔨" },
        { text = "Option 2", value = "b", count = 2, icon = "🧪" },
        { text = "Option 3", value = "c", count = 3, icon = "🔧" },
        { text = "Option 4", value = "c", count = 3, level = 1 },
    },
    -- format = "text",
    format = function(item, picker)
        print(item.text)
        local indent = string.rep("  ", item.level or 0) -- Отступ 2 пробела на уровень
        local icon = item.icon or "▪" -- Иконка типа символа
        local name = item.text or "<unknown>"

        -- Собираем финальную строку с отступом, иконкой и именем
        local formatted = string.format("%s%s %s", indent, icon, name)
        print(formatted)
        -- Можно добавить обрезку по длине, например, если > 50 символов
        if #formatted > 50 then
            formatted = formatted:sub(1, 47) .. "..."
        end
        print("test")
        return { { formatted, "Normal" } }
    end,
    -- format = "lsp_symbol",
    preview = "preview",
    confirm = function(picker, item)
        print("Selected: " .. item.text)
    end,
    style = "minimal",
    layout = {
        preset = "vertical", -- "default" | "vertical" | "sidebar" | "vscode" | custom
        cycle = true, -- Enable cursor wrapping at list edges
        reverse = false, -- Reverse list order (bottom-up)
        fullscreen = false, -- Open in fullscreen
        hidden = { "input", "preview" }, -- Windows to hide on open: ["input"] | ["preview"]
        auto_hide = {}, -- Windows to auto-hide when not focused: ["input"]
    },
    win = {
        list = {
            size = 0.1,
        },
    },
    -- highlight = {
    --     title = "SnacksTitle",
    --     border = "SnacksBorder",
    --     cursor = "SnacksCursor",
    --     selected = "SnacksSelected",
    -- },
}
local lsp_mod = {
    finder = "lsp_incoming_calls",
    format = "lsp_symbol",
    include_current = false,
    workspace = true, -- this ensures the file is included in the formatter
    auto_confirm = true,
    jump = { tagstack = true, reuse_win = true },
}

local state = require("neo-tree.sources.manager").get_state("filesystem")

if state and state.path then
    -- print("Root path neo-tree: " .. state.path)
else
    -- print("Root path neo-tree не доступен")
end
-- print(vim.loop.cwd())
local opt = {
    name = "cmake_terminal",
    position = "bottom", -- положение
}
-- local terminal =  Snacks.terminal.get("ls -la", opt)
-- terminal:send("ls")
-- local terminal = Snacks.terminal.get( {
-- name = "my-terminal",
-- cwd = vim.loop.cwd(), -- текущая директория
-- cwd = M.proj_dir,
-- shell = vim.env.SHELL, -- используемая оболочка
-- on_open = function(term)
--     -- term:send("ls -la") -- команда при открытии
--     --
--     pcall(function()
--         term:send("ls -la")
--     end)
-- end,
-- })

-- term:open("ls", {})
-- if terminal then
--     -- Терминал найден, можно с ним работать
--     print("Терминал найден:", terminal.winid) -- Пример: id окна терминала
-- else
--     -- Терминал не найден
--     print("Терминал с таким именем отсутствует")
-- end
-- terminal.toggle()
-- Snacks.picker.pick(lsp_mod)
-- Snacks.picker.pick(my_opts)
