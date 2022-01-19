local vim = vim
local cmp = require 'cmp'
local luasnip = require 'luasnip'

local M = {}

local menu = {
    gh_issues = '[issue]',
    nvim_lua  = '[lua]',
    nvim_lsp  = '[lsp]',
    luasnip   = '[snip]',
    path      = '[path]',
    buffer    = '[buf]',
}

local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

function M.setup()

    cmp.setup {

        completion = {
            keyword_length = 3,
            autocomplete = false,
        },

        documentation = {
            border = 'single',
        },

        snippet = {
            expand = function(args) require'luasnip'.lsp_expand(args.body) end,
        },

        mapping = {
            ['<CR>'] = cmp.config.disable,
            ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs( 4), { 'i', 'c' }),
            ['<C-n>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { 'i', 'c' }),
            ['<C-p>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { 'i', 'c' }),
            ['<C-e>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.abort()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 'c', 's' }),
            ['<C-y>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.confirm {
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    }
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    end
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 'c', 's' }),
        },

        sources = cmp.config.sources({
            -- { name = 'gh_issues' },
            { name = 'nvim_lua' },
            { name = 'nvim_lsp' },
        }, {
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'buffer', keyword_length = 5 },
        }),

        formatting = {
            format = function(entry, vim_item)
                vim_item.menu = menu[entry.source.name]
                return vim_item
            end,
        },

    }

end

return M
