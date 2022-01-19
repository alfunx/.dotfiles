local vim = vim
local ts_config = require 'nvim-treesitter.configs'

local M = {}

function M.setup()

    ts_config.setup {

        ensure_installed = "maintained",
        -- ensure_installed = { "bash", "c", "cpp", "css", "go", "html", "java", "latex", "lua", "php", "python", "rust", "vim", "norg", "query" },
        ignore_install = { },

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },

        incremental_selection = {
            enable = false,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            },
        },

        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@comment.outer",
                    ["ir"] = "@assignment.rhs",
                    ["il"] = "@assignment.lhs",
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                },
            },

            swap = {
                enable = true,
                    swap_next = {
                        ["<leader>a"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>A"] = "@parameter.inner",
                    },
            },

            lsp_interop = {
                enable = true,
                border = 'single',
                peek_definition_code = {
                    ["<leader>gf"] = "@function.inner",
                    ["<leader>gF"] = "@class.outer",
                },
            },
        },

        playground = {
            enable = true,
            disable = {},
            updatetime = 25,
            persist_queries = true,
            keybindings = {
                toggle_query_editor = 'o',
                toggle_hl_groups = 'i',
                toggle_injected_languages = 't',
                toggle_anonymous_nodes = 'a',
                toggle_language_display = 'I',
                focus_language = 'f',
                unfocus_language = 'F',
                update = 'R',
                goto_node = '<cr>',
                show_help = '?',
            },
        },

        query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = {"BufWrite", "CursorHold"},
        },

    }

end

return M
