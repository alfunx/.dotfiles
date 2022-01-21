local vim = vim
local lspconfig = require 'lspconfig'

local M = {}

function M.setup()

    -- local capabilities = require'cmp_nvim_lsp'.update_capabilities(
    --     vim.lsp.protocol.make_client_capabilities()
    -- )

    lspconfig.bashls.setup {
        -- capabilities = capabilities,
    }

    lspconfig.ccls.setup {
        -- capabilities = capabilities,
    }

    lspconfig.gopls.setup {
        -- capabilities = capabilities,
    }

    lspconfig.jdtls.setup {
        -- capabilities = capabilities,
    }

    lspconfig.kotlin_language_server.setup {
        -- capabilities = capabilities,
    }

    lspconfig.pylsp.setup {
        -- capabilities = capabilities,
    }

    lspconfig.rust_analyzer.setup {
        -- capabilities = capabilities,
    }

    lspconfig.texlab.setup {
        -- capabilities = capabilities,
    }

    lspconfig.vimls.setup {
        -- capabilities = capabilities,
    }

    lspconfig.sumneko_lua.setup {
        cmd = { 'lua-language-server' },
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
        -- capabilities = capabilities,
    }

    -- override handlers

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = {
                prefix = '←',
                spacing = 0,
                severity = { min = vim.diagnostic.severity.HINT }
            },
            signs = {
                priority = 30,
                severity = { min = vim.diagnostic.severity.HINT }
            },
            severity_sort = true,
            update_in_insert = false,
        }
    )

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
            border = 'single',
        }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
            border = 'single',
        }
    )

    -- -- display only most severe sign per line
    -- local set_signs = vim.lsp.diagnostic.set_signs
    -- vim.lsp.diagnostic.set_signs = function(diagnostics, bufnr, client_id, sign_ns, opts)
    --     if not diagnostics then return end
    --
    --     local diagnostic = {}
    --     for _, d in pairs(diagnostics) do
    --         if not diagnostic[d.range.start.line]
    --                 or d.severity < diagnostic[d.range.start.line].severity then
    --             diagnostic[d.range.start.line] = d
    --         end
    --     end
    --
    --     local filtered_diagnostics = {}
    --     for _, v in pairs(diagnostic) do
    --         table.insert(filtered_diagnostics, v)
    --     end
    --
    --     set_signs(filtered_diagnostics, bufnr, client_id, sign_ns, opts)
    -- end

    -- -- display only most severe sign per line (if sorted by severity)
    -- local set_signs = vim.lsp.diagnostic.set_signs
    -- vim.lsp.diagnostic.set_signs = function(diagnostics, bufnr, client_id, sign_ns, opts)
    --     if not diagnostics then return end
    --     local line, filtered = {}, {}
    --     for i = #diagnostics, 1, -1 do
    --         if not line[diagnostics[i].range.start.line] then
    --             line[diagnostics[i].range.start.line] = diagnostics[i]
    --             table.insert(filtered, diagnostics[i])
    --         end
    --     end
    --     set_signs(filtered, bufnr, client_id, sign_ns, opts)
    -- end

end

function M.signature_help_insert()
    return vim.lsp.buf_request(0, 'textDocument/signatureHelp',
        vim.lsp.util.make_position_params(),
        vim.lsp.with(
            vim.lsp.handlers["textDocument/signatureHelp"], {
                border = 'single',
                close_events = { 'InsertLeave' },
                focusable = false,
            }
        )
    )
end

return M
