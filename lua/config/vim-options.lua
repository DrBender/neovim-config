-- Main settings
vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = true
vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true -- allow undo files, so you can undo after restarting neovim
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
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

-- Enable Tree-sitter folding
vim.opt.foldmethod = 'expr'       -- Setting the folding method to 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'  -- Use the Tree-sitter function to collapse
vim.opt.foldlevel = 99            -- Open all collapsed blocks by default (you can reduce them to collapse)
vim.opt.foldenable = true         -- enable folding



vim.g.netrw_liststyle = 3     -- the tree list
vim.g.netrw_browse_split = 4  -- open in new tab
vim.g.netrw_altv = 1          -- vertical panel
vim.g.netrw_winsize = 25      -- panel width (%)
-- vim.g.netrw_home = os.getenv("HOME") .. "/.cache/netrw"  -- cache
-- vim.g.netrw_ssh_cmd = "ssh -p 2222"vim.g.netrw_ssh_cmd = "ssh -p 2222"
