local M = {}
M.opts = {
    title = "🎯 CMake Presets",
    prompt = "Select preset:",
    border = "rounded",
    -- width = 70,
    -- width = 10,
    -- height = 18,
    style = "minimal",
    confirm = function(picker, item)
        if item and item.data then
            M.execute_preset(item.data.type, item.data.name)
            picker:close()
        end
    end,
    keymaps = {
        close = { "q", "<Esc>", "<C-c>" },
        submit = { "<CR>", "<Space>" },
    },
    format = function(item, picker)
        print(item.text)
        local indent = string.rep("   ", item.level or 0)
        local icon = item.icon or "▪"
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
M.icons = {
    Build = "🔨",
    Test = "🧪",
    Workflow = "🔧",
    Configure = " ",
    Default = "⚡",
}
function M.setup()
    vim.keymap.set("n", "<leader>mp", function()
        M.fancy_cmake_presets()
    end, { desc = "Show CMake Presets" })
    vim.env.SHELL = "powershell.exe"

end
local function get_project_dir()
    local state = require("neo-tree.sources.manager").get_state("filesystem")
    local dir = vim.fn.getcwd()
    if state and state.path then
        print("Root path neo-tree: " .. state.path)
        dir = state.path
    else
        print("Root path neo-tree не доступен")
    end
    return dir
end

function M.get_cmake_presets_from_cli()
    -- Check if cmake is available
    if vim.fn.executable("cmake") == 0 then
        vim.notify("CMake is not installed or not in PATH", vim.log.levels.ERROR)
        return {}
    end

    M.proj_dir = get_project_dir()
    local cmd = "cd " .. M.proj_dir .. " && cmake --list-presets=all"
    local handle = io.popen(cmd)
    if not handle then
        vim.notify("Failed to execute cmake command: " .. cmd, vim.log.levels.ERROR)
        return {}
    end

    local output = handle:read("*a")
    handle:close()

    if output == "" then
        vim.notify("No output from cmake --list-presets", vim.log.levels.WARN)
        return {}
    end

    -- local preset_file = vim.fn.findfile("CMakePresets.json", ".;")
    -- if preset_file == "" then
    --     vim.notify("CMakePresets.json not found", vim.log.levels.WARN)
    --     return
    -- end

    -- Parse output
    M.presets = {
        Configure = {},
        Build = {},
        Test = {},
        Workflow = {},
        Package = {},
        All = {},
    }

    local current_section = nil
    for line in output:gmatch("[^\r\n]+") do
        line = line:gsub("^%s*(.-)%s*$", "%1") -- trim
        if line:match("configure presets:") then
            current_section = "Configure"
        elseif line:match("build presets:") then
            current_section = "Build"
        elseif line:match("test presets:") then
            current_section = "Test"
        elseif line:match("workflow presets:") then
            current_section = "Workflow"
        elseif line:match("package presets:") then
            current_section = "Package"
        elseif line:match("^Available preset names:") then
            current_section = "All"
        elseif current_section and line ~= "" and not line:match("^[%-=]") then
            local preset_name = line:match('^"([^"]+)"') or line:match("^([^%s]+)")
            local description = line:match('"%s*-%s*(.+)"') or line:match("%s*-%s*(.+)")

            if preset_name then
                table.insert(M.presets[current_section], {
                    name = preset_name,
                    description = description or "",
                })
            end
        end
    end
end

function M.fancy_cmake_presets()
    -- local presets, err = M.get_cmake_presets_from_cli()
    M.get_cmake_presets_from_cli()
    if not M.presets then
        vim.notify("Presets empty", vim.log.levels.ERROR)
        return
    end

    local menu_items = {}
    -- local section_order = { "Configure", "Build", "Test", "Workflow", "Package", "All" }
    local section_order = { "Workflow", "Configure", "Build", "Test", "Package", "All" }

    for _, section_name in ipairs(section_order) do
        if M.presets[section_name] then
            local section_item = {
                icon = M.icons[section_name],
                text = section_name .. " presets",
            }

            table.insert(menu_items, section_item)
            for _, preset in ipairs(M.presets[section_name]) do
                table.insert(menu_items, {
                    -- text = string.format("%s %s", icon, preset.name),
                    text = preset.name,
                    description = preset.description,
                    level = 1,
                    data = {
                        name = preset.name,
                        type = section_name,
                    },
                })
            end
        end
    end
    M.opts.items = menu_items
    Snacks.picker.pick(M.opts)
end

function M.select_preset(preset_name)
    vim.notify("Selected CMake preset: " .. preset_name, vim.log.levels.INFO)

    local command = string.format("!cmake --preset %s", preset_name)
    vim.cmd(command)
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

function M.execute_preset(preset_type, preset_name)
    local commands = {
        Configure = "cmake --preset %s",
        Build = "cmake --build --preset %s",
        Test = "ctest --preset %s",
        Workflow = "cmake --workflow --preset %s",
        Package = "cmake --package --preset %s",
        All = "cmake --preset %s",
    }
    local command_template = commands[preset_type] or commands.All
    local command = "cd " .. M.proj_dir .. " && " .. string.format(command_template, preset_name) .. "\r\n"

    -- vim.notify(string.format("Executing: %s %s", preset_type:lower(), preset_name), vim.log.levels.INFO)

    vim.notify(string.format("Executing: %s", command), vim.log.levels.INFO)
    -- vim.cmd("vsplit | terminal " .. command)
    M.send_or_open_terminal(command)
    -- Snacks.terminal.toggle(command)
    -- vim.cmd("terminal "..command)
end

M:setup()

return M
