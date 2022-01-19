local vim = vim
local neorg = require 'neorg'
local parsers = require 'nvim-treesitter.parsers'

local M = {}

function M.setup()

    neorg.setup {
        load = {
            ["core.defaults"] = {},
            ["core.norg.concealer"] = {},
            ["core.norg.dirman"] = {
                config = {
                    workspaces = {
                        my_workspace = "~/neorg"
                    }
                }
            }
        },
    }

    parsers.get_parser_configs().norg = {
        install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg",
            files = { "src/parser.c", "src/scanner.cc" },
            branch = "main"
        },
    }

end

return M
