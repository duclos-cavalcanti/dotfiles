-- vim.pack manifest: declare every plugin here; configure them in the per-topic
-- files required at the bottom. Lockfile: nvim-pack-lock.json (commit it).

-- Build hooks (vim.pack has no `build =`): must be registered before add().
-- On "install" the plugin isn't loaded yet, so packadd before running it.
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
            if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
            vim.cmd("TSUpdate")
        end
    end,
})

vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/nvim-mini/mini.extra" },
    { src = "https://github.com/nvim-mini/mini.completion" },
    { src = "https://github.com/nvim-mini/mini.icons" },
    { src = "https://github.com/nvim-mini/mini.statusline" },
    { src = "https://github.com/nvim-mini/mini.tabline" },
    { src = "https://github.com/nvim-mini/mini.base16" },
    { src = "https://github.com/nvim-mini/mini.diff" },
    { src = "https://github.com/nvim-mini/mini-git" },

    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

require("plugins.core")    -- treesitter + LSP + local agentic plugin
require("plugins.pick")    -- fuzzy picker
require("plugins.theme")   -- colorscheme + UI
require("plugins.git")     -- mini.diff (hunks) + mini.git (blame/commands)
