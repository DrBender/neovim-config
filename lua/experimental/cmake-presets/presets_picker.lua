local M = {}
M.opts = {
    title = "🎯 CMake Presets",
    prompt = "Select preset:",
    border = "rounded",
    width = 70,
    height = 18,
    style = "minimal",
    confirm = function(picker, item)
        if item and item.data then
            print(item.data.type .. item.data.name)
            M.execute_preset(item.data.type, item.data.name)
        end
    end,
    keymaps = {
        close = { "q", "<Esc>", "<C-c>" },
        submit = { "<CR>", "<Space>" },
    },
    format = function(item, picker)
        print(item.text)
        local indent = string.rep("  ", item.level or 0) 
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
        preset = "default", -- "default" | "vertical" | "sidebar" | "vscode" | custom
        cycle = true, -- Enable cursor wrapping at list edges
        reverse = false, -- Reverse list order (bottom-up)
        fullscreen = false, -- Open in fullscreen
        hidden = { "input" }, -- Windows to hide on open: ["input"] | ["preview"]
        auto_hide = {}, -- Windows to auto-hide when not focused: ["input"]
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
end

function M.get_cmake_presets_from_cli()
    -- Check if cmake is available
    if vim.fn.executable("cmake") == 0 then
        vim.notify("CMake is not installed or not in PATH", vim.log.levels.ERROR)
        return {}
    end

    -- Run command: cmake --list-presets
    local cmd = "cmake --list-presets=all"
    local handle = io.popen(cmd)
    if not handle then
        vim.notify("Failed to execute cmake command", vim.log.levels.ERROR)
        return {}
    end

    local output = handle:read("*a")
    handle:close()

    if output == "" then
        vim.notify("No output from cmake --list-presets", vim.log.levels.WARN)
        return {}
    end

    local preset_file = vim.fn.findfile("CMakePresets.json", ".;")
    if preset_file == "" then
        vim.notify("CMakePresets.json not found", vim.log.levels.WARN)
        return
    end

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
            vim.notify("configure section", vim.log.levels.ERROR)
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

function M.show_win_cmake_presets()
    M:get_cmake_presets_from_cli()

    local buf = vim.api.nvim_create_buf(false, true)
    local width = 60
    local height = math.min(20, 20)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Window parameters
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
        title = "CMake Presets",
        title_pos = "center",
    })
    -- Buffer options
    vim.bo[buf].filetype = "cmake-presets"
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].modifiable = true

    local section_order = { "configure", "build", "test", "workflow", "package", "all" }
    local section_names = {
        configure = "Configure",
        build = "Build",
        test = "Test",
        workflow = "Workflow",
        package = "Package",
        all = "All",
    }
    -- Подготавливаем содержимое
    local lines = {
        "CMake Presets:",
        "=" .. string.rep("=", width - 2),
        "Type      | Name",
        "----------" .. string.rep("-", width - 10),
        "",
    }
    for _, section_key in ipairs(section_order) do
        local section_presets = M.presets[section_key] or {}
        for i, preset in ipairs(section_presets) do
            local line = string.format("%s", preset.name)
            -- table.insert(all_presets, {
            --     type = section_names[section_key],
            --     name = preset.name,
            --     description = preset.description
            -- })
            table.insert(lines, line)
        end
    end

    table.insert(lines, "")
    table.insert(lines, "Press <Enter> to select, <q> to close")
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    -- Устанавливаем ключевые mappings
    vim.keymap.set("n", "q", function()
        vim.api.nvim_win_close(win, true)
    end, { buffer = buf })

    vim.keymap.set("n", "<Esc>", function()
        vim.api.nvim_win_close(win, true)
    end, { buffer = buf })

    vim.keymap.set("n", "<CR>", function()
        local line = vim.api.nvim_get_current_line()
        M.select_preset(line)
        -- local number = line:match("^(%d+)%.")
        -- if number then
        --     local index = tonumber(number)
        --     local preset = M.presets[index]
        --     if preset then
        --         vim.api.nvim_win_close(win, true)
        --         M.select_preset(preset.name)
        --     end
        -- end
    end, { buffer = buf })

    -- Подсветка
    vim.api.nvim_buf_add_highlight(buf, -1, "Title", 0, 0, -1)
    vim.api.nvim_buf_add_highlight(buf, -1, "Comment", 1, 0, -1)
    for i = 3, #lines - 2 do
        vim.api.nvim_buf_add_highlight(buf, -1, "Normal", i, 0, -1)
    end
    vim.api.nvim_buf_add_highlight(buf, -1, "Comment", #lines - 1, 0, -1)
end

-- Более красивый вариант с кастомным форматированием
function M.fancy_cmake_presets()
    -- local presets, err = M.get_cmake_presets_from_cli()
    M.get_cmake_presets_from_cli()
    if not M.presets then
        vim.notify("Presets empty", vim.log.levels.ERROR)
        return
    end

    local menu_items = {}
    -- local section_order = { "Configure", "Build", "Test", "Workflow", "Package", "All" }
    local section_order = { "Workflow","Configure", "Build", "Test",  "Package", "All" }

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
    local command = string.format(command_template, preset_name)

    vim.notify(string.format("Executing: %s %s", preset_type:lower(), preset_name), vim.log.levels.INFO)

    vim.cmd("vsplit | terminal " .. command)
end

M:setup()

return M
