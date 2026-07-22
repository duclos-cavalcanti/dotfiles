-- Plugin manifest. A single vim.pack.add() lists every plugin the config uses
-- (echasnovski's recommended vim.pack pattern). Declaration lives here;
-- configuration (setup, keymaps, runtime autocmds) lives in the per-topic files
-- required at the bottom -- never inside the spec.
--
-- vim.pack.add() clones each `src` into
--   ~/.local/share/nvim/site/pack/core/opt/<name>
-- puts it on 'runtimepath', and pins revisions in ~/.config/nvim/nvim-pack-lock.json
-- (commit that lockfile). Update all: `:lua vim.pack.update()`.

-- Build/install hooks: vim.pack has no `build =` field. These run on
-- install/update and MUST be registered before vim.pack.add() to fire on first
-- install. On "install" the plugin is not loaded yet, so packadd first.
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
    { src = "https://github.com/nvim-mini/mini.completion" },
    { src = "https://github.com/nvim-mini/mini.icons" },
    { src = "https://github.com/nvim-mini/mini.statusline" },
    { src = "https://github.com/nvim-mini/mini.tabline" },
    { src = "https://github.com/nvim-mini/mini.base16" },
    { src = "https://github.com/nvim-mini/mini.diff" },
    { src = "https://github.com/nvim-mini/mini-git" }, -- repo is mini-git; module is mini.git
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
})

require("plugins.core")    -- treesitter + LSP + local agentic plugin
require("plugins.pick")    -- fuzzy picker
require("plugins.theme")   -- colorscheme + UI
require("plugins.git")     -- mini.diff (hunks) + mini.git (blame/commands)
