local M = {}
M.opts = {
    title = "🎯 Build Configurations",
    prompt = "Select:",
    border = "rounded",
    -- width = 70,
    -- width = 10,
    -- height = 18,
    style = "minimal",
    confirm = function(picker, item)
        print(item.data.name)
        -- if item and item.data then
        M.execute_preset(item.data.num, item.data.name)
        picker:close()
        -- end
    end,
    keymaps = {
        close = { "q", "<Esc>", "<C-c>" },
        submit = { "<CR>", "<Space>" },
    },
    format = function(item, picker)
        print(item.text)
        local indent = string.rep("   ", item.level or 0)
        local icon = item.icon or "▪️"
        local name = item.text or "<unknown>"

        local formatted = string.format("%s%s %s", indent, icon, name)
        print(formatted)
        if #formatted > 50 then
            formatted = formatted:sub(1, 47) .. "..."
        end
        print("test")
        return { { formatted, "Text" } }
    end,
    highlight = {
        title = "SnacksTitle",
        border = "SnacksBorder",
        cursor = "SnacksCursor",
        selected = "SnacksSelected",
    },
    layout = {
        preset = "vertical", -- "default" | "vertical" | "sidebar" | "vscode" | custom
        -- position = "right",
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
}

-- local lfs = require("lfs")

function findProFile(directory)
    for file in lfs.dir(directory) do
        if file:match("%.pro$") then
            return file
        end
    end
    return nil
end

-- function findProFile()
--     local command
--
--     if package.config:sub(1,1) == "/" then
--         command = 'ls -1 *.pro 2>/dev/null | head -1'
--     else
--         command = 'for /f "tokens=*" %%i in (\'dir /b *.pro 2^>nul\') do echo %%i & exit /b'
--     end
--
--     local handle = io.popen(command)
--     if handle then
--         local result = handle:read("*l")
--         handle:close()
--         return result
--     end
--
--     return nil
-- end

function M.setup()
    vim.keymap.set("n", "<leader>bq", function()
        M.qmake_presets()
    end, { desc = "Show QMake Presets" })
    vim.env.SHELL = "powershell.exe"
end
M.configs = {
    "Make",
    "Make clean",
    "QMake x86 qpa",
    "QMake x86 qws",
    "QMake ppc qpa",
    "QMake ppc qws",
}
function M.qmake_presets()
    local menu_items = {}
    local icon = ""
    for i, conf_name in ipairs(M.configs) do
        table.insert(menu_items, {
            text = string.format("[%s] %s %s", i, icon, conf_name),
            -- text = conf_name,
            description = "",
            level = 1,
            data = {
                num = i,
                name = conf_name,
            },
        })
    end
    M.opts.items = menu_items
    Snacks.picker.pick(M.opts)
end

function M.execute_preset(preset_num, preset_name)
    local commands = require("experimental.cmake-presets.qmake-commands")
    -- local commands = require("qmake-commands")
    print("commands = " .. commands)

    local proFile = findProFile(".")
    if proFile then
        print("Найден .pro файл:", proFile)
        local command_template = commands[preset_num] or ""
        local command = "cd " .. M.proj_dir .. " && " .. string.format(command_template, proFile) .. "\r\n"

        -- vim.notify(string.format("Executing: %s %s", preset_type:lower(), preset_name), vim.log.levels.INFO)

        vim.notify(string.format("Executing: %s", command), vim.log.levels.INFO)
        -- vim.cmd("vsplit | terminal " .. command)
        M.send_or_open_terminal(command)
    -- Snacks.terminal.toggle(command)
    -- vim.cmd("terminal "..command)
    else
        print(".pro файл не найден")
    end
end

M:setup()

return M
