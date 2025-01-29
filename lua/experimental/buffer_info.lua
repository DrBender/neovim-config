local plugin = "Info Plugin"

vim.notify = require("notify")

-- vim.notify("This is an error message.\nSomething went wrong!", "error", {
--     title = plugin,
--     on_open = function()
--         vim.notify("Attempting recovery.", vim.log.levels.WARN, {
--             title = plugin,
--         })
--         local timer = vim.loop.new_timer()
--         timer:start(2000, 0, function()
--             vim.notify({ "Fixing problem.", "Please wait..." }, "info", {
--                 title = plugin,
--                 timeout = 3000,
--                 on_close = function()
--                     vim.notify("Problem solved", nil, { title = plugin })
--                     vim.notify("Error code 0x0395AF", 1, { title = plugin })
--                 end,
--             })
--         end)
--     end,
-- })

function ShowBufferInfo()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    local info = ""
    local buf_client_names = {}

    for _, client in ipairs(clients) do
        table.insert(buf_client_names, client.name)
        -- if client.name ~= "null-ls" then
        --     table.insert(buf_client_names, client.name)
        -- end
    end
    local unique_client_names = table.concat(buf_client_names, ", ")
    local language_servers = string.format("[%s]", unique_client_names)
    local buf_number = vim.api.nvim_get_current_buf()
    local buf_name = vim.api.nvim_buf_get_name(buf_number)

    info = info .. "Buf Number: " .. buf_number .. "\nBuf Name: " .. buf_name
    info = info .. "\nClient names: " .. unique_client_names .. "\nLanguage servers: " .. language_servers

    vim.notify(info, vim.log.levels.INFO, { title = plugin, timeout = 10000 })
end

vim.api.nvim_set_keymap(
    "n",
    "<leader>i",
    "<cmd>lua ShowBufferInfo()<CR>",
    { desc = "Info Buffer", noremap = true, silent = true }
)
