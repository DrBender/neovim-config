local M = {}
M.methods = {}

M.config = function()
    -- local status_cmp_ok, cmp_types = pcall(require, "cmp.types.cmp")
    -- if not status_cmp_ok then
    -- return
    -- end
    -- local ConfirmBehavior = cmp_types.ConfirmBehavior
    -- local SelectBehavior = cmp_types.SelectBehavior
    -- vim.api.nvim_create_
    local cmp = require("cmp")
    -- local cmp = require("lvim.utils.modules").require_on_index "cmp"
    -- local luasnip = require("lvim.utils.modules").require_on_index "luasnip"
    local cmp_window = require("cmp.config.window")
    -- local cmp_mapping = require "cmp.config.mapping"
    -- vim.api.nvim_create
    pvim.builtin.cmp = {
        active = true,
        on_config_done = nil,
        -- enabled = function()
        --     local buftype = vim.api.nvim_buf_get_option(0, "buftype")
        --     if buftype == "prompt" then
        --         return false
        --     end
        --     return lvim.builtin.cmp.active
        -- end,
        -- confirm_opts = {
        --     behavior = ConfirmBehavior.Replace,
        --     select = false,
        -- },
        completion = {
            ---@usage The minimum length of a word to complete on.
            keyword_length = 1,
        },
        experimental = {
            ghost_text = false,
            native_menu = false,
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            -- max_width = 0,
            kind_icons = pvim.icons.kind,
            source_names = {
                nvim_lsp = "(LSP)",
                emoji = "(Emoji)",
                path = "(Path)",
                calc = "(Calc)",
                cmp_tabnine = "(Tabnine)",
                vsnip = "(Snippet)",
                luasnip = "(Snippet)",
                buffer = "(Buffer)",
                tmux = "(TMUX)",
                copilot = "(Copilot)",
                treesitter = "(TreeSitter)",
            },
            duplicates = {
                buffer = 1,
                path = 1,
                nvim_lsp = 0,
                luasnip = 1,
            },
            duplicates_default = 0,
            format = function(entry, vim_item)
                vim_item.kind = pvim.builtin.cmp.formatting.kind_icons[vim_item.kind]

                vim_item.menu = pvim.builtin.cmp.formatting.source_names[entry.source.name]
                vim_item.dup = pvim.builtin.cmp.formatting.duplicates[entry.source.name]
                    or pvim.builtin.cmp.formatting.duplicates_default
                return vim_item
            end,

            -- format = function(entry, vim_item)
            --     local max_width = lvim.builtin.cmp.formatting.max_width
            --     if max_width ~= 0 and #vim_item.abbr > max_width then
            --         vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. lvim.icons.ui.Ellipsis
            --     end
            --     if lvim.use_icons then
            --         vim_item.kind = lvim.builtin.cmp.formatting.kind_icons[vim_item.kind]
            --
            --         if entry.source.name == "copilot" then
            --             vim_item.kind = lvim.icons.git.Octoface
            --             vim_item.kind_hl_group = "CmpItemKindCopilot"
            --         end
            --
            --         if entry.source.name == "cmp_tabnine" then
            --             vim_item.kind = lvim.icons.misc.Robot
            --             vim_item.kind_hl_group = "CmpItemKindTabnine"
            --         end
            --
            --         if entry.source.name == "crates" then
            --             vim_item.kind = lvim.icons.misc.Package
            --             vim_item.kind_hl_group = "CmpItemKindCrate"
            --         end
            --
            --         if entry.source.name == "lab.quick_data" then
            --             vim_item.kind = lvim.icons.misc.CircuitBoard
            --             vim_item.kind_hl_group = "CmpItemKindConstant"
            --         end
            --
            --         if entry.source.name == "emoji" then
            --             vim_item.kind = lvim.icons.misc.Smiley
            --             vim_item.kind_hl_group = "CmpItemKindEmoji"
            --         end
            --     end
            --     vim_item.menu = lvim.builtin.cmp.formatting.source_names[entry.source.name]
            --     vim_item.dup = lvim.builtin.cmp.formatting.duplicates[entry.source.name]
            --         or lvim.builtin.cmp.formatting.duplicates_default
            --     return vim_item
            -- end,
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
                -- luasnip.lsp_expand(args.body)
            end,
        },
        window = {
            completion = cmp_window.bordered(),
            documentation = cmp_window.bordered(),
        },
        sources = {
            {
                name = "nvim_lsp",
                -- entry_filter = function(entry, ctx)
                --     local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
                --     if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                --         return false
                --     end
                --     return true
                -- end,
            },
            { name = "nvim_lsp_signature_help" },
            { name = "path" },
            { name = "luasnip" },
            { name = "cmp_tabnine" },
            { name = "nvim_lua" },
            { name = "buffer" },
            { name = "calc" },
            { name = "emoji" },
            { name = "treesitter" },
            { name = "crates" },
            { name = "tmux" },
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        -- mapping = cmp_mapping.preset.insert {
        --     ["<C-k>"] = cmp_mapping(cmp_mapping.select_prev_item(), { "i", "c" }),
        --     ["<C-j>"] = cmp_mapping(cmp_mapping.select_next_item(), { "i", "c" }),
        --     ["<Down>"] = cmp_mapping(cmp_mapping.select_next_item { behavior = SelectBehavior.Select }, { "i" }),
        --     ["<Up>"] = cmp_mapping(cmp_mapping.select_prev_item { behavior = SelectBehavior.Select }, { "i" }),
        --     ["<C-d>"] = cmp_mapping.scroll_docs(-4),
        --     ["<C-f>"] = cmp_mapping.scroll_docs(4),
        --     ["<C-y>"] = cmp_mapping {
        --         i = cmp_mapping.confirm { behavior = ConfirmBehavior.Replace, select = false },
        --         c = function(fallback)
        --             if cmp.visible() then
        --                 cmp.confirm { behavior = ConfirmBehavior.Replace, select = false }
        --             else
        --                 fallback()
        --             end
        --         end,
        --     },
        --     ["<Tab>"] = cmp_mapping(function(fallback)
        --         if cmp.visible() then
        --             cmp.select_next_item()
        --         elseif luasnip.expand_or_locally_jumpable() then
        --             luasnip.expand_or_jump()
        --         elseif jumpable(1) then
        --             luasnip.jump(1)
        --         elseif has_words_before() then
        --             -- cmp.complete()
        --             fallback()
        --         else
        --             fallback()
        --         end
        --     end, { "i", "s" }),
        --     ["<S-Tab>"] = cmp_mapping(function(fallback)
        --         if cmp.visible() then
        --             cmp.select_prev_item()
        --         elseif luasnip.jumpable(-1) then
        --             luasnip.jump(-1)
        --         else
        --             fallback()
        --         end
        --     end, { "i", "s" }),
        --     ["<C-Space>"] = cmp_mapping.complete(),
        --     ["<C-e>"] = cmp_mapping.abort(),
        --     ["<CR>"] = cmp_mapping(function(fallback)
        --         if cmp.visible() then
        --             local confirm_opts = vim.deepcopy(lvim.builtin.cmp.confirm_opts) -- avoid mutating the original opts below
        --             local is_insert_mode = function()
        --                 return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
        --             end
        --             if is_insert_mode() then -- prevent overwriting brackets
        --                 confirm_opts.behavior = ConfirmBehavior.Insert
        --             end
        --             local entry = cmp.get_selected_entry()
        --             local is_copilot = entry and entry.source.name == "copilot"
        --             if is_copilot then
        --                 confirm_opts.behavior = ConfirmBehavior.Replace
        --                 confirm_opts.select = true
        --             end
        --             if cmp.confirm(confirm_opts) then
        --                 return -- success, exit early
        --             end
        --         end
        --         fallback() -- if not exited early, always fallback
        --     end),
        -- },
        cmdline = {
            enable = false,
            options = {
                {
                    type = ":",
                    sources = {
                        { name = "path" },
                        { name = "cmdline" },
                    },
                },
                {
                    type = { "/", "?" },
                    sources = {
                        { name = "buffer" },
                    },
                },
            },
        },
    }
end

function M.setup()
    local cmp = require("cmp")
    M:config()
    cmp.setup(pvim.builtin.cmp)

    -- if lvim.builtin.cmp.cmdline.enable then
    --   for _, option in ipairs(lvim.builtin.cmp.cmdline.options) do
    --     cmp.setup.cmdline(option.type, {
    --       mapping = cmp.mapping.preset.cmdline(),
    --       sources = option.sources,
    --     })
    --   end
    -- end

    -- if lvim.builtin.cmp.on_config_done then
    --   lvim.builtin.cmp.on_config_done(cmp)
    -- end
end

return M

-- return {
--     {
--         -- nvim-cmp source for neovim builtin LSP client
--         "hrsh7th/cmp-nvim-lsp",
--     },
--     {
--         -- Snippet Engine for Neovim written in Lua.
--         "L3MON4D3/LuaSnip",
--         dependencies = {
--             -- luasnip completion source for nvim-cmp
--             "saadparwaiz1/cmp_luasnip",
--             "rafamadriz/friendly-snippets",
--         },
--     },
--     {
--         -- A completion plugin for neovim coded in Lua.
--         "hrsh7th/nvim-cmp",
--         config = function()
--             local cmp = require("cmp")
--             require("luasnip.loaders.from_vscode").lazy_load()
--
--             cmp.setup({
--                 snippet = {
--                     expand = function(args)
--                         require("luasnip").lsp_expand(args.body)
--                     end,
--                 },
--                 window = {
--                     completion = cmp.config.window.bordered(),
--                     documentation = cmp.config.window.bordered(),
--                 },
--                 mapping = cmp.mapping.preset.insert({
--                     ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--                     ["<C-f>"] = cmp.mapping.scroll_docs(4),
--                     ["<C-Space>"] = cmp.mapping.complete(),
--                     ["<C-e>"] = cmp.mapping.abort(),
--                     ["<CR>"] = cmp.mapping.confirm({ select = true }),
--                 }),
--                 formatting = {
--                     --
--                     fields = { "kind", "abbr", "menu" },
--                     --     max_width = 0,
--                     source_names = {
--                         nvim_lsp = "(LSP)",
--                         -- emoji = "(Emoji)",
--                         -- path = "(Path)",
--                         -- calc = "(Calc)",
--                         -- cmp_tabnine = "(Tabnine)",
--                         -- vsnip = "(Snippet)",
--                         -- luasnip = "(Snippet)",
--                         -- buffer = "(Buffer)",
--                         -- tmux = "(TMUX)",
--                         -- copilot = "(Copilot)",
--                         -- treesitter = "(TreeSitter)",
--                     },
--                     format = function(entry, vim_item)
--                         -- local max_width --считывать из конфига
--                         local max_width = 0
--                         local icons = require("icons")
--                         -- vim_item.menu = entry.source.name
--                         -- vim_item.kind = icons[vim_item.kind]
--                         vim_item.menu = source_names[entry.source.name]
--                         -- vim_item.dup =
--                         return vim_item
--                     end,
--                 },
--                 sources = cmp.config.sources({
--                     { name = "nvim_lsp" },
--                     { name = "luasnip" }, -- For luasnip users.
--                 }, {
--                     { name = "buffer" },
--                 }),
--
--                 sorting = {
--                     comparators = {
--                         cmp.config.compare.offset,
--                         cmp.config.compare.exact,
--                         cmp.config.compare.recently_used,
--                         require("clangd_extensions.cmp_scores"),
--                         cmp.config.compare.kind,
--                         cmp.config.compare.sort_text,
--                         cmp.config.compare.length,
--                         cmp.config.compare.order,
--                     },
--                 },
--             })
--             -- vim
--             -- vim.api.nvim_create_
--             -- vim.api.nvim_create
--             -- vim.api.nvim_create
--         end,
--         -- dependencies = {
--         --     "cmp-nvim-lsp",
--         --     "cmp_luasnip",
--         --     -- "cmp-buffer",
--         --     -- "cmp-path",
--         --     -- "cmp-cmdline",
--         -- },
--         -- dependencies = {
--         --     "hrsh7th/cmp-nvim-lsp",
--         --     dependencies = {
--         --         "L3MON4D3/LuaSnip",
--         --         "hrsh7th/cmp-buffer",
--         --         "hrsh7th/cmp-path",
--         --         "hrsh7th/cmp-cmdline",
--         --         "hrsh7th/cmp-nvim-lua",
--         --         "hrsh7th/cmp-emoji",
--         --         "chrisgrieser/cmp-nerdfont",
--         --         "ray-x/cmp-treesitter",
--         --         "saadparwaiz1/cmp_luasnip",
--         --         "roobert/tailwindcss-colorizer-cmp.nvim",
--         --         "Exafunction/codeium.nvim",
--         --     },
--         -- },
--     },
-- }
