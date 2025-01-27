local opt = vim.opt

opt.number = true
vim.wo.number = true

opt.clipboard = "unnamedplus"


-- Indent Settings
vim.opt.expandtab = true 
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true 
vim.opt.cindent = true     
vim.opt.smarttab = true    


opt.mouse = "a"        -- Enable mouse
opt.encoding = "utf-8" 
opt.fileencoding = "utf-8"
opt.showcmd = true     

opt.cursorline = true

opt.termguicolors = true
