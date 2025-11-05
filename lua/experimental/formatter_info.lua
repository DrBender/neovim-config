function ShowFormatterInfo()
    print("=== Функция ShowFormatterInfo вызвана ===")

    local bufnr = vim.api.nvim_get_current_buf()
    local filetype = vim.bo[bufnr].filetype
    print("Текущий файл: " .. filetype)

    local formatters = require("conform").list_formatters(bufnr)
    print("Найдено форматтеров: " .. #formatters)

    if #formatters == 0 then
        vim.notify("❌ Нет доступных форматтеров для " .. filetype, vim.log.levels.WARN)
        return
    end

    local formatter_names = {}
    for _, formatter in ipairs(formatters) do
        table.insert(formatter_names, formatter.name)
    end

    print("Форматтеры: " .. table.concat(formatter_names, ", "))

    local start_time = vim.loop.hrtime()
    vim.notify("🚀 Запуск: " .. table.concat(formatter_names, ", "), vim.log.levels.INFO)
    -- Форматируем и обрабатываем промис
    local success, result = pcall(function()
        return require("conform").format({
            bufnr = bufnr,
            timeout_ms = 5000,
            -- async = true,
        })
    end)

    -- Если форматирование завершилось синхронно
    if success then
        local end_time = vim.loop.hrtime()
        local duration_ms = (end_time - start_time) / 1e6
        vim.notify(string.format("✅ Успешно! (%dms)", duration_ms), vim.log.levels.INFO, { title = "Conform" })
    else
        -- Если форматирование асинхронное, показываем общее уведомление
        vim.defer_fn(function()
            vim.notify("✅ Форматирование завершено", vim.log.levels.INFO)
        end, 100)
    end
end

vim.keymap.set("n", "<leader>if", ShowFormatterInfo, { desc = "Format with notify" })
-- vim.api.nvim_set_keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",
--
--     { desc = "Code Action", noremap = true, silent = true })
--
-- -- require("clangd_extensions.inlay_hints").setup_autocmd()
-- -- require("clangd_extensions.inlay_hints").set_inlay_hints()
-- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
-- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
-- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
-- vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format Code" })
function ShowAvailableLinters()
    local bufnr = vim.api.nvim_get_current_buf()
    local filetype = vim.bo[bufnr].filetype

    -- Получаем доступные линтеры для текущего файла
    local linters = require("lint").get_linters_by_ft(filetype)

    if #linters == 0 then
        vim.notify("❌ Нет доступных линтеров для " .. filetype, vim.log.levels.WARN)
        return
    end

    local linter_names = {}
    for _, linter in ipairs(linters) do
        table.insert(linter_names, linter.name)
    end

    local message = "📝 Доступные линтеры для " .. filetype .. ":\n"
    for i, name in ipairs(linter_names) do
        message = message .. string.format("%d. %s\n", i, name)
    end

    vim.notify(message, vim.log.levels.INFO, { title = "nvim-lint", timeout = 5000 })
end

vim.keymap.set("n", "<leader>il", ShowAvailableLinters, { desc = "Show available linters" })
