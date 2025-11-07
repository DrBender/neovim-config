-- Вызов функции, например, из командной строки Neovim:
-- :lua select_example()
local my_opts = {
    title = "🎯 CMake Presets",
    prompt = "Select preset:",
    border = "rounded",
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
        local icon = item.icon or "▪"-- Иконка типа символа
        local name = item.text or "<unknown>"

        -- Собираем финальную строку с отступом, иконкой и именем
        local formatted = string.format("%s%s %s", indent, icon, name)
        print(formatted)
        -- Можно добавить обрезку по длине, например, если > 50 символов
        if #formatted > 50 then
            formatted = formatted:sub(1, 47) .. "..."
        end
        print("test")
        return {{formatted, "Normal"}}
        -- return {
        --     -- { item.text, "Normal" },
        --     { item.icon, "Text" },
        --     { item.text, "Text" },
        --     { " (" .. item.count .. ")", "Comment", virtual = true },
        -- }
    end,
    -- format = "lsp_symbol",
    preview = "preview",
    confirm = function(picker, item)
        print("Selected: " .. item.text)
    end,
    style = "minimal",
    layout = {
        preset = "default", -- "default" | "vertical" | "sidebar" | "vscode" | custom
        cycle = true, -- Enable cursor wrapping at list edges
        reverse = false, -- Reverse list order (bottom-up)
        fullscreen = false, -- Open in fullscreen
        hidden = { "input" }, -- Windows to hide on open: ["input"] | ["preview"]
        auto_hide = {}, -- Windows to auto-hide when not focused: ["input"]
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
-- Snacks.picker.pick(lsp_mod)
-- Snacks.picker.pick(my_opts)

-- Создаем функцию для инициализации пикера
local function init_presets_picker()
    Snacks.picker.pick({
        title = "Preset Selector",
        items = {
            -- Конфигурационные пресеты
            {
                text = "Configure Presets",
                submenu = {
                    {
                        text = "cmake-x86-qpa",
                        description = "CMake x86 qpa",
                        action = function()
                            -- Действие при выборе cmake-x86-qpa
                            print("Selected cmake-x86-qpa")
                        end,
                    },
                    {
                        text = "cmake-x86-qws",
                        description = "CMake x86 qws",
                        action = function()
                            -- Действие при выборе cmake-x86-qws
                            print("Selected cmake-x86-qws")
                        end,
                    },
                },
            },
            -- Пресеты сборки
            {
                text = "Build Presets",
                submenu = {
                    {
                        text = "build-x86-qpa",
                        action = function()
                            -- Действие при выборе build-x86-qpa
                            print("Selected build-x86-qpa")
                        end,
                    },
                },
            },
            -- Пресеты workflow
            {
                text = "Workflow Presets",
                submenu = {
                    {
                        text = "work-x86-qpa",
                        description = "WorkFlow x86 qpa",
                        action = function()
                            -- Действие при выборе work-x86-qpa
                            print("Selected work-x86-qpa")
                        end,
                    },
                },
            },
        },
        confirm = function(picker, item)
            if item.action then
                item.action()
                picker:close()
            end
        end,
    })
end

-- Пример привязки клавиши для открытия пикера
vim.keymap.set("n", "<leader>p", init_presets_picker, { desc = "Open Presets Picker" })
-- ---@type snacks.picker.lsp.Config

-- ---@type snacks.picker.lsp.Config
-- {
--   finder = "lsp_incoming_calls",
--   format = "lsp_symbol",
--   include_current = false,
--   workspace = true, -- this ensures the file is included in the formatter
--   auto_confirm = true,
--   jump = { tagstack = true, reuse_win = true },
-- }
--
-- M.opts = {
--     title = "🎯 CMake Presets",
--     prompt = "Select preset:",
--     border = "rounded",
--     width = 70,
--     height = 18,
--     style = "minimal",
--     on_submit = function(selected)
--         if selected and selected.data then
--             M.execute_preset(selected.data.type, selected.data.name)
--         end
--     end,
--     keymaps = {
--         close = { "q", "<Esc>", "<C-c>" },
--         submit = { "<CR>", "<Space>" },
--     },
--     -- Кастомная подсветка
--     highlight = {
--         title = "SnacksTitle",
--         border = "SnacksBorder",
--         cursor = "SnacksCursor",
--         selected = "SnacksSelected",
--     },
--     icons = {
--         build = "🔨",
--         test = "🧪",
--         workflow = "🔧",
--         configure = "",
--         default = "⚡",
--     },
-- }
