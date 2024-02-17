local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
    { -- ssh
        'nosduco/remote-sshfs.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        config = function() 
            -- require('ex.ssh') 
            require('remote-sshfs').setup({})
            require('telescope').load_extension 'remote-sshfs'
        end
    },
    { -- lsp
        "neovim/nvim-lspconfig",
        config = function() require('ex.lspconfig') end,
    },
    { -- job manager / overseer
        'stevearc/overseer.nvim',
        opts = {},
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-telescope/telescope.nvim",
            "rcarriga/nvim-notify",
        },
        config = function() 
            require('overseer').setup()
        end,
    },
    { -- completion
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function() require('ex.completion') end,
    },
    { -- fuzzy finder
        'nvim-telescope/telescope.nvim',
        dependencies = {
            {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
            'nvim-telescope/telescope-dap.nvim',
            'nvim-lua/plenary.nvim',
        },
        config = function() require('ex.telescope') end,
    },
    { -- file-brwoser
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    { -- treesitter
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "windwp/nvim-ts-autotag",
        },
        config = function() require('ex.treesitter') end,
    },
    { -- markdown
        "iamcco/markdown-preview.nvim",
        config = function()
            vim.fn["mkdp#util#install"]()
            vim.cmd[[
            function OpenMarkdownPreview (url)
                execute "silent ! firefox --new-tab " . a:url
            endfunction
            let g:mkdp_browserfunc = 'OpenMarkdownPreview'
            ]]
        end,
    },
    { -- snippets
        "L3MON4D3/LuaSnip",
        config = function() 
            local s = require('ex.luasnip')
            s.config()
            s.setup()
        end,
    },
    { -- debugger
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                config = function() require("ex.debugger-ui") end,
            },
        },
        config = function() require('ex.debugger') end
    },
    { -- git
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",

            "nvim-telescope/telescope.nvim",
            "ibhagwan/fzf-lua",
      },
        config = function() 
            local neogit = require('neogit')
            neogit.setup {}
        end
    },
    { -- auto pairs
        "windwp/nvim-autopairs",
        config = function() require('nvim-autopairs').setup({}) end
    }, 
    { -- comment
        "numToStr/Comment.nvim",
        config = function() require('ex.comment') end,
    },
    { -- themes/ui
        "https://github.com/Mofiqul/adwaita.nvim",
        'nvim-lualine/lualine.nvim',
        dependencies = {
                'kyazdani42/nvim-web-devicons', 
                {
                    'norcalli/nvim-colorizer.lua',
                    config  = function() require('colorizer').setup() end,
                }
        },
    },
}

local opts = {

}

require("lazy").setup(plugins, opts)
