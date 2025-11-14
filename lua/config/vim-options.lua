-- Main settings
vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
-- vim.opt.colorcolumn = "80"
vim.opt.cursorline = true

-- vim.g.mapleader = 

vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

vim.opt.splitright = true  -- vertical split right
vim.opt.splitbelow = true  -- horizontal split below

vim.opt.list = true
vim.opt.listchars = { space = "·", tab = ">-" }

vim.opt.fillchars = { eob = '~', vert = '|', fold = '-' }


vim.opt.mouse = "a" -- Enable mouse
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.showcmd = true

-- Включаем Tree-sitter folding
vim.opt.foldmethod = 'expr'       -- Установка метода сворачивания на 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'  -- Использовать функцию Tree-sitter для сворачивания
vim.opt.foldlevel = 99            -- Открыть все свёрнутые блоки по умолчанию (можно уменьшить для сворачивания)
vim.opt.foldenable = true         -- Включить сворачивание



vim.g.netrw_liststyle = 3        -- древовидный список
vim.g.netrw_browse_split = 4    -- открывать в новой вкладке
vim.g.netrw_altv = 1          -- вертикальная панель
vim.g.netrw_winsize = 25      -- ширина панели (в %)
-- vim.g.netrw_home = os.getenv("HOME") .. "/.cache/netrw"  -- кэш
-- vim.g.netrw_ssh_cmd = "ssh -p 2222"vim.g.netrw_ssh_cmd = "ssh -p 2222"
-- ssh -o MACs=hmac-sha1 pkrv@192.168.5.56 -p 22
