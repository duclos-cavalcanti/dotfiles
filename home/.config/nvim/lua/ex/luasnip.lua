local ls = require "luasnip"

local M = {}

function M.config()
    ls.config.set_config {
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
    }
end

function M.setup()
    ls.cleanup()
    -- read snippets lazily from the snippets folder besides init.lua
    require("luasnip.loaders.from_snipmate").lazy_load()

    -- examples inspired by
    -- https://github.com/honza/vim-snippets/tree/master/snippets
end

return M

