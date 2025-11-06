return {
    "Civitasv/cmake-tools.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- "mfussenegger/nvim-dap",
    },
    config = function()
        require("cmake-tools").setup({
            cmake_command = "cmake",
            cmake_use_preset = true,
            cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
            cmake_build_directory = "build",
            cmake_build_directory_prefix = "build/",
            -- cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
            -- cmake_build_options = {},
            cmake_console_size = 10, -- размер окна с выводом CMake
            cmake_show_console = "always", -- всегда показывать консоль
            -- cmake_dap_configuration = {
            --     name = "cpp",
            --     type = "codelldb",
            --     request = "launch",
            -- }, -- конфигурация для дебага
            cmake_variants_message = {
                short = { show = true },
                long = { show = true, max_length = 40 },
            },
            cmake_executor = {
                new_task_opts={
                overseer = {
                    strategy = "toggleterm",
                    direction = "horizontal",
                    auto_scroll = true,
                    quit_on_exit = "success"
                }
                },
                on_new_task = function (task)
                    require("overseer").open(
                        {enter = false, direct = "right"}
                    ) 
                end
            }
        })
    end,
}
