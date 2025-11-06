local M = {}

function M.setup()
    vim.keymap.set("n", "<leader>mp", function()
        M.show_win_cmake_presets()
    end, { desc = "Show CMake Presets" })
end
function M.read_presets()
    -- Проверяем наличие файла CMakePresets.json
    local preset_file = vim.fn.findfile("CMakePresets.json", ".;")
    if preset_file == "" then
        vim.notify("CMakePresets.json not found", vim.log.levels.WARN)
        return
    end

    -- Читаем и парсим JSON файл
    local content = vim.fn.readfile(preset_file)
    local ok, json_data = pcall(vim.fn.json_decode, table.concat(content, "\n"))
    if not ok then
        vim.notify("Failed to parse CMakePresets.json", vim.log.levels.ERROR)
        return
    end
    -- Извлекаем список пресетов
    M.presets = json_data.configurePresets or {}

    if vim.tbl_isempty(M.presets) then
        vim.notify("No configure presets found", vim.log.levels.INFO)
        return
    end
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
        configure = {},
        build = {},
        test = {},
        workflow = {},
        package = {},
        all = {},
    }

    local current_section = nil
    for line in output:gmatch("[^\r\n]+") do
        line = line:gsub("^%s*(.-)%s*$", "%1") -- trim
        if line:match("configure presets:") then
            vim.notify("configure section", vim.log.levels.ERROR)
            current_section = "configure"
        elseif line:match("build presets:") then
            current_section = "build"
        elseif line:match("test presets:") then
            current_section = "test"
        elseif line:match("workflow presets:") then
            current_section = "workflow"
        elseif line:match("package presets:") then
            current_section = "package"
        elseif line:match("^Available preset names:") then
            current_section = "all"
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
    -- M:read_presets()
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
    -- Устанавливаем опции буфера
    vim.api.nvim_buf_set_option(buf, "filetype", "cmake-presets")
    vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(buf, "modifiable", true)

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
    -- for i, preset in ipairs(M.presets) do
    --     local type_str = string.format("%-9s", preset.type)
    --     -- local display_name = preset.displayName or preset.name
    --     -- local line = string.format('%d. %s (%s)', i, display_name, preset.name)
    --     -- table.insert(lines, line)
    --     local line = string.format("%d. %s | %s", i, type_str, preset.name)
    --
    --     if preset.description ~= "" then
    --         line = line .. string.format(" - %s", preset.description)
    --     end
    --
    --     table.insert(lines, line)
    -- end

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

function M.select_preset(preset_name)
    -- Здесь можно добавить логику для использования пресета
    vim.notify("Selected CMake preset: " .. preset_name, vim.log.levels.INFO)

    -- Пример: установка переменной окружения
    -- vim.fn.setenv('CMAKE_PRESET', preset_name)

    -- Или выполнение команды CMake
    local command = string.format("!cmake --preset %s", preset_name)
    vim.cmd(command)
end

M:setup()
return M
