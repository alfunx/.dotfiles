local vim = vim
local util = require 'vim.lsp.util'
local api = vim.api
local lsp = vim.lsp

local M = {}

local function handler(err, result, ctx, config)
    config = config or {}
    config.focus_id = ctx.method
    if not (result and result.signatures and result.signatures[1]) then
        print('No signature help available')
        return
    end

    local signature = result.signatures[result.activeSignature+1]
    local parameter = signature.parameters[result.activeParameter+1]
    local hl
    if parameter then
        if type(parameter.label) == 'string' then
            local s, e = string.find(signature.label, parameter.label)
            hl = { s - 1, e }
        elseif type(parameter.label) == 'table' then
            hl = parameter.label
        end
    end

    local ft = api.nvim_buf_get_option(ctx.bufnr, 'filetype')
    local lines = util.convert_signature_help_to_markdown_lines(result, ft)
    lines = util.trim_empty_lines(lines)
    if vim.tbl_isempty(lines) then
        print('No signature help available')
        return
    end

    local fbuf, fwin = util.open_floating_preview(lines, 'markdown', config)
    api.nvim_buf_add_highlight(fbuf, -1, 'SpellBad', 0, unpack(hl))

    return fbuf, fwin
end

function M.insert()
    return lsp.buf_request(0, 'textDocument/signatureHelp',
        util.make_position_params(),
        lsp.with(
            handler, {
                border = 'single',
                hl_group = 'SpellBad',
                close_events = { 'InsertLeave' },
                focusable = false,
            }
        )
    )
end

function M.normal()
    return lsp.buf_request(0, 'textDocument/signatureHelp',
        util.make_position_params(),
        lsp.with(
            handler, {
                border = 'single',
                hl_group = 'SpellBad',
            }
        )
    )
end

return M
