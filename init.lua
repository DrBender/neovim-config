P_vim = vim.deepcopy(require("config.default"))

require("config.vim-options")
require("config.commands")
require("core.lazy")

require("lazy").setup("plugins")

require("core.lsp")
-- require("lsp.lua_ls_conf")
require("config.keymaps")

require("experimental.buffer_info")
require("experimental.formatter_info")
require("experimental.user_commands")


require("experimental.cmake-presets.presets_picker")
require("experimental.cmake-presets.qmake-picker")

require("experimental.cmake-presets.test")
