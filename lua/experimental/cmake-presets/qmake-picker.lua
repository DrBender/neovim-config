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

local function get_project_dir()
    local state = require("neo-tree.sources.manager").get_state("filesystem")
    local dir = vim.fn.getcwd()
    if state and state.path then
        print("Root path neo-tree: " .. state.path)
        dir = state.path
        local folder_name = vim.fn.fnamemodify(dir, ":t")
        print("Имя папки:", folder_name)
        M.pro_file = folder_name .. ".pro"
    else
        print("Root path neo-tree не доступен")
        M.pro_file = nil
    end
    return dir
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
-- M.configs = {
--     "Make",
--     "Make clean",
--     "QMake x86 qpa",
--     "QMake x86 qws",
--     "QMake ppc qpa",
--     "QMake ppc qws",
-- }
-- M.configs = require("lua.experimental.cmake-presets.qmake-commands")

M.configs = require("experimental.cmake-presets.qmake-commands")

function M.qmake_presets()
    local menu_items = {}
    local icon = ""
    for _, config in ipairs(M.configs) do
        table.insert(menu_items, {
            text = string.format("[%s] %s %s", config.id, icon, config.name),
            -- text = conf_name,
            description = "",
            level = 1,
            data = {
                num = config.id,
                name = config.name,
            },
        })
    end
    M.opts.items = menu_items
    Snacks.picker.pick(M.opts)
end
function M.send_or_open_terminal(cmd)
    print("1")
    local snacks_term_bufnr = nil
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_get_option(bufnr, "buftype") == "terminal" then
            snacks_term_bufnr = bufnr
            break
        end
    end
    -- print("snacks_term_bufnr = " .. snacks_term_bufnr)

    print("2")
    if snacks_term_bufnr then
        local chan = vim.b[snacks_term_bufnr].terminal_job_id
        if chan then
            vim.fn.chansend(chan, cmd .. "\n")
            return
        end
    end

    print("3")
    -- Создание терминала с базовыми настройками
    local term = Snacks.terminal.get(nil, {
        name = "my-terminal",
        cwd = M.proj_dir or vim.loop.cwd(),
    })
    print("4")
  local chan = vim.bo[term.buf].channel
  vim.defer_fn(function()
    vim.fn.chansend(chan, { cmd })
  end, 100)
end
-- TODO: parse all pro files in folder
-- show dialog to chose pro-file and show in status bar current target-pro-file
function M.execute_preset(num, preset_name)
    -- local commands = require("experimental.cmake-presets.qmake-commands")
    -- local commands = require("qmake-commands")
    -- print("commands = " .. commands)
    M.proj_dir = get_project_dir()

    if M.pro_file then
        print("Найден .pro файл:", M.pro_file, num)
        local command_template = (M.configs[num].path .. " " .. M.configs[num].options) or ""
        local command = "cd " .. M.proj_dir .. " && " .. string.format(command_template, M.pro_file) .. "\r\n"

        -- vim.notify(string.format("Executing: %s %s", preset_type:lower(), preset_name), vim.log.levels.INFO)

        vim.notify(string.format("Executing: %s", command), vim.log.levels.INFO)
        -- vim.cmd("vsplit | terminal " .. command)
        M.send_or_open_terminal(command)
    -- Snacks.terminal.toggle(command)
    -- vim.cmd("terminal "..command)
    else
        -- print(".pro файл не найден")
    end
end

print("TEsd " .. M.configs[1].id)

M:setup()

return M
