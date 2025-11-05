 local null_ls = require("null-ls")    
local no_fucks = {
            method = null_ls.methods.DIAGNOSTICS,
            filetypes = { "markdown", "text", "lua" },
            generator = {
                fn = function(params)
                    local diagnostics = {}
                    -- sources have access to a params object
                    -- containing info about the current file and editor state
                    for i, line in ipairs(params.content) do
                        local col, end_col = line:find("fuck")
                        if col and end_col then
                            -- null-ls fills in undefined positions
                            -- and converts source diagnostics into the required format
                            table.insert(diagnostics, {
                                row = i,
                                col = col,
                                end_col = end_col + 1,
                                source = "no-fucks",
                                message = "Don't use 'fuck!'",
                                severity = vim.diagnostic.severity.WARN,
                            })
                        end
                    end
                    return diagnostics
                end,
            },
        }
return no_fucks
