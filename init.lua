pvim = vim.deepcopy(require("configs.default"))

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("vim-options")

require("lazy").setup("plugins")

require("keymaps")

require("experimental.diagn_icons_change")
require("experimental.buffer_info")
require("experimental.build.build_cmake")
