local cmp = require'cmp'
local ls = require "luasnip"

cmp.setup({
    snippet = {
        -- REQUIRED
        expand = function(args)
        require('luasnip').lsp_expand(args.body) -- luasnip users.
      end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable,
        ['<C-Space>'] = function(fallback)
                            if cmp.visible() then
                                cmp.close()
                            else
                                cmp.complete()
                            end
                         end,
        ['<C-n>'] = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
        ['<C-p>'] = function(fallback)
                          if cmp.visible() then
                              cmp.select_prev_item()
                          else
                              fallback()
                          end
                      end,
        ['<C-k>'] = cmp.mapping(function(fallback)
                        if ls.expand_or_jumpable() then
                            ls.expand_or_jump()
                        else
                            fallback()
                        end
                      end, {"i", "s"}),
        ['<C-j>'] = cmp.mapping(function(fallback)
                        if ls.jumpable(-1) then
                            ls.jump(-1)
                        else
                            fallback()
                        end
                      end, {"i", "s"}),
        ['<C-l>'] = cmp.mapping(function(fallback)
                        if ls.choice_active() then
                            ls.change_choice(1)
                        else
                            fallback()
                        end
                      end, {"i", "s"}),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

  -- Use buffer source for `/`
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
