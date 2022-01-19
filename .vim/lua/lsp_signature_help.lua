local vim = vim
local util = require 'vim.lsp.util'
local api = vim.api
local lsp = vim.lsp

local M = {}

local fbuf, fwin, hl, hl_old, hlns

local function triggered(chars)
    local pos = api.nvim_win_get_cursor(0)
    local line = api.nvim_get_current_line():sub(1, pos[2])
    local current = string.sub(line, -1)
    return not not string.find(table.concat(chars), current:gsub("([^%w])", "%%%1"))
end

local function first_section(text, chars)
    local length = #text
    for _, c in ipairs(chars) do
        local _, new_length = string.find(text, c:gsub("([^%w])", "%%%1"))
        if new_length and new_length < length then
            length = new_length
        end
    end
    return length
end

local function cleanup()
    if fwin and api.nvim_win_is_valid(fwin) then
        api.nvim_win_close(fwin, true)
        fbuf, fwin, hl, hl_old = nil, nil, nil, nil
    end
end

local function handler(err, result, ctx, config)
    config = config or {}
    config.focus_id = ctx.method
    if not (result and result.signatures and result.signatures[1]) then
        cleanup()
        if config.silent ~= true then
            print('No signature help available')
        end
        return
    end
    local client = lsp.get_client_by_id(ctx.client_id)
    local triggers = client.resolved_capabilities.signature_help_trigger_characters
    -- if not triggered(triggers) then return end

    local signature = result.signatures[result.activeSignature+1]
    local parameter = signature.parameters[result.activeParameter+1]
    hl_old = hl
    if parameter then
        if type(parameter.label) == 'string' then
            local s, e = string.find(signature.label, parameter.label)
            hl = { s - 1, e }
        elseif type(parameter.label) == 'table' then
            hl = parameter.label
        end
    end
    if hl_old and hl and hl[1] == hl_old[1] then return end

    local ft = api.nvim_buf_get_option(ctx.bufnr, 'filetype')
    local lines = util.convert_signature_help_to_markdown_lines(result, ft, triggers)
    lines = util.trim_empty_lines(lines)
    if vim.tbl_isempty(lines) then
        cleanup()
        if config.silent ~= true then
            print('No signature help available')
        end
        return
    end

    config.offset_x = -hl[1] - (config.border and 1 or 0)
    if not (fwin and api.nvim_win_is_valid(fwin)) then
        fbuf, fwin = util.open_floating_preview(lines, 'markdown', config)
    end
    if hlns then
        api.nvim_buf_clear_namespace(fbuf, hlns, 0, -1)
    else
        hlns = api.nvim_create_namespace('lsp_signatureHelp_currentParameter')
    end
    if hl then
        api.nvim_buf_add_highlight(fbuf, hlns, 'SpellBad', 0, unpack(hl))
    end

    return fbuf, fwin
end

function M.insert()
    return lsp.buf_request(0, 'textDocument/signatureHelp',
        util.make_position_params(),
        lsp.with(
            handler, {
                border = 'single',
                close_events = { 'InsertLeave' },
                focusable = false,
                hl_group = 'SpellBad',
                silent = true,
            }
        )
    )
end

api.nvim_command("autocmd TextChangedP <buffer> lua require'lsp_signature_help'.insert()")
api.nvim_command("autocmd TextChangedI <buffer> lua require'lsp_signature_help'.insert()")
api.nvim_command("autocmd CursorMovedI <buffer> lua require'lsp_signature_help'.insert()")
api.nvim_command("autocmd InsertEnter  <buffer> lua require'lsp_signature_help'.insert()")

return M
