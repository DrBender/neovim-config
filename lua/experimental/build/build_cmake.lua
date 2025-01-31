local popup = require("plenary.popup")

local win_id
local win_id_build


function ShowMenuBuild(opts, cb)
    local height = 20
    local width = 30
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

    win_id_build = popup.create(opts, {
        title = "Build Configurations",
        highlight = "MyProjectWindow",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars,
        callback = cb,
    })
    -- Define custom highlight groups
    vim.cmd("highlight PopupTitle guifg=Yellow guibg=Black")

    local bufnr = vim.api.nvim_win_get_buf(win_id_build)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua CloseMenuBuild()<CR>", { silent = false })
    -- Optional: Set some buffer options (e.g., make it non-editable)
    -- vim.api.nvim_buf_set_option(bufnr, "modifiable", false)

    vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
    vim.api.nvim_buf_set_option(bufnr, "buftype", "nofile")

    vim.api.nvim_buf_add_highlight(bufnr, -1, "PopupTitle", 0, 0, -1) -- First line

    -- Set autocmd to close the popup window when focus is lost
    -- Set autocmd to close the popup window when focus is lost
    vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
        buffer = bufnr,
        nested = true,
        once = true,
        callback = function()
            pcall(vim.api.nvim_win_close, win_id_build, true)
        end,
    })
end

function CloseMenu()
    vim.api.nvim_win_close(win_id, true)
end

function CloseMenuBuild()
    vim.api.nvim_win_close(win_id_build, true)
end

local Terminal = require("toggleterm.terminal").Terminal
pvim.build_term = Terminal:new({
    -- cmd = "$MYSHELL && ls -l /",
    display_name = "build",
    -- dir = "/home/tech/work_repos/test/VSK_BM_SM_QNX/",
    -- close_on_exit = true,
    auto_scroll = true,
    hidden = true,
    count = 101,

    direction = "horizontal",
    float_opts = {
        border = "double",
    },
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function(term)
        -- print("FUCK YOU")
        vim.cmd("startinsert!")
    end,
})
function _build_toggle()
    pvim.build_term:toggle()
    -- build_term:open()
end

_build_toggle()
_build_toggle()

vim.keymap.set("n", "<leader>x", "<cmd>lua _build_toggle()<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>bu", "<cmd>lua _build_toggle()<cr>", { noremap = true, silent = true })
function BuildMenu()
    local ico = pvim.icons.kind.Property
    local ico_run = pvim.icons.ui.Triangle
    local setups = require("experimental.build.config")
    local path = setups.scripts_path

    local current_dir = vim.fn.getcwd()

    local configs = {
        path,
        ico_run .. " Run",
        "-------------------------",
        ico .. " Make",
        ico .. " Make clean",
        ico .. " QMake x86 qpa",
        ico .. " QMake x86 qws",
        ico .. " QMake ppc qpa",
        ico .. " QMake ppc qws",
        "-------------------------",
        ico .. " QMake local clang",
        ico .. " QMake local gcc",
        "",
        "",
        "",
        "",
        "Script path: " .. path,
        "Current dir: " .. current_dir,
    }

    local cb = function(_, sel)
        print("Picked:" .. sel .. path)
        local dir = vim.fn.getcwd()

        require("toggleterm").exec("cd " .. dir, pvim.build_term.count, 12)
        local command = ""
        if sel == ico .. " Make" then
            command = "sh " .. path .. "make.sh make"
        elseif sel == ico .. " Make clean" then
            command = "sh " .. path .. "make.sh clean"
        elseif sel == ico .. " QMake x86 qpa" then
            -- print("QMake x86 qpa")
            command = "sh " .. path .. "qmake.sh x86 qpa"
        elseif sel == ico .. " QMake x86 qws" then
            -- print("QMake x86 qws")
            command = "sh " .. path .. "qmake.sh x86 qws"
        elseif sel == ico .. " QMake ppc qpa" then
            -- print("QMake ppc qpa")
            command = "sh " .. path .. "qmake.sh ppc qpa"
        elseif sel == ico .. " QMake ppc qws" then
            -- print("QMake ppc qws")
            command = "sh " .. path .. "qmake.sh ppc qws"
        elseif sel == ico .. " QMake local clang" then
            command = "sh " .. path .. "qmake.sh local clang"
        elseif sel == ico .. " QMake local gcc" then
            command = "sh " .. path .. "qmake.sh local gcc"
        elseif sel == ico_run .. " Run" then
            command = "sh " .. path .. "run.sh"
        end

        require("toggleterm").exec(command, pvim.build_term.count, 12)
    end
    ShowMenuBuild(configs, cb)
end

vim.keymap.set("n", "<leader>mb", "<cmd>lua BuildMenu()<CR>", { desc = "My Build" })
