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
    { -- lsp
        "neovim/nvim-lspconfig",
        config = function() require('ex.lspconfig') end,
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
    { -- treesitter
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "windwp/nvim-ts-autotag",
        },
        config = function() require('ex.treesitter') end,
    },
    { -- file browser
        'stevearc/oil.nvim',
        config = function() require('oil').setup() end
    },
    { -- snippets
        "L3MON4D3/LuaSnip",
        config = function() 
            local s = require('ex.luasnip')
            s.config()
            s.setup()
        end,
    },
    { -- tagsbar
        'simrat39/symbols-outline.nvim',
        config = function() require('ex.tagsbar') end
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
    { -- auto pairs
        "windwp/nvim-autopairs",
        config = function() require('nvim-autopairs').setup({}) end
    }, 
    { -- formatting
        'mhartington/formatter.nvim',
        config = function() require('ex.format') end
    },
    { -- comment
        "numToStr/Comment.nvim",
        config = function() require('ex.comment') end,
    },
    { -- themes/ui
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
