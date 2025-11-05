return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")
        local config = lualine.get_config()

        config.options = { theme = "dracula" }
        config.options.ignore_focus = { "neo-tree" }
        -- config.sections.lualine_b = {"buffers"}
        -- Inserts a component in lualine_c at left section
        local function ins_left(component)
            table.insert(config.sections.lualine_c, component)
        end
        -- Inserts a component in lualine_x at right section
        local function ins_right(component)
            table.insert(config.sections.lualine_x, component)
        end
        ins_left({
            function()
                local buf_client_names = {}

                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then
                    return "LSP Inactive"
                end

                for _, client in ipairs(clients) do
                    if client.name ~= "null-ls" then
                        table.insert(buf_client_names, client.name)
                    end
                end
                local unique_client_names = table.concat(buf_client_names, ", ")
                local language_servers = string.format("[%s]", unique_client_names)
                return language_servers
            end,
            icon = " LSP:",
            color = { fg = "#51afef" },
        })
        lualine.setup(config)
    end,
}
