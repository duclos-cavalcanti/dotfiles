local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path})
end

-- Rerun PackerCompile everytime pluggins.lua is updated
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

-- Load Packer
vim.cmd([[packadd packer.nvim]])

return require('packer').startup(function(use)
    -- plugin manager packer
    use "wbthomason/packer.nvim"

    -- lsp and completion
    use {
        "neovim/nvim-lspconfig",
        config = function() require('ex.lspconfig') end,
    }

    use {
        "hrsh7th/nvim-cmp",
        -- Sources for nvim-cmp
        requires = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-cmdline",
          "hrsh7th/cmp-nvim-lua",
          "saadparwaiz1/cmp_luasnip",
        },
        config = function() require('ex.completion') end,
      }

    -- fuzzy finder and picker
    use {'nvim-telescope/telescope.nvim',
          config = function() require('ex.telescope') end,
          requires = {
              {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
              'nvim-telescope/telescope-dap.nvim',
              'nvim-lua/plenary.nvim',
          },
      }

    -- file browser
    use {
      'nvim-tree/nvim-tree.lua',
       config = function() require('ex.file-browser') end,
      requires = { 'nvim-tree/nvim-web-devicons'},
    }

    -- treesitter
    use { "nvim-treesitter/nvim-treesitter",
          config = function() require('ex.treesitter') end,
        }

    -- debugger
    use { "mfussenegger/nvim-dap",
          config = function() require('ex.debugger') end,
      }

    -- debugger ui
    use { "rcarriga/nvim-dap-ui",
           config = function() require("ex.debugger-ui") end,
           requires = {"mfussenegger/nvim-dap"} }

    -- tagsbar / tags outliner
    use { 'simrat39/symbols-outline.nvim',
          config = function() require('ex.tagsbar') end
        }

    -- snippets
    use {
        "L3MON4D3/LuaSnip",
        config = function()
            local s = require('ex.luasnip')
            s.config()
            s.setup()
        end
    }

    -- autopairs, html autotagging
    use {
        "windwp/nvim-autopairs",
        requires = { "windwp/nvim-ts-autotag" },
        config = function() require('ex.pair') end,
    }

    use {
        'mhartington/formatter.nvim',
        config = function() require('ex.format') end,
    }

    -- comment utility
    use {
        "numToStr/Comment.nvim",
        config = function() require('ex.comment') end,
    }

    -- themes/ui
    use { 'nvim-lualine/lualine.nvim',
          requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }

    -- view colors in nvim
    use { 'norcalli/nvim-colorizer.lua',
           config  = function() require('colorizer').setup() end,
        }

    if packer_bootstrap then
        require('packer').sync()
        vim.cmd [[TSUpdate]]
    end
end)
