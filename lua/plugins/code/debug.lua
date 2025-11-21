return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- Конфигурация для Lua
        dap.configurations.lua = {
            {
                type = "nlua",
                request = "attach",
                name = "Attach to running Neovim",
                host = function()
                    return "127.0.0.1"
                end,
                port = function()
                    return 54231
                end,
            },
        }

        dap.adapters.nlua = function(callback, config)
            callback({ type = "server", host = config.host, port = config.port })
        end

        -- Автоматическое открытие/закрытие UI
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end
    end,
}
