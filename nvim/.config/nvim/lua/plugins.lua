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

    -- finder, file browser and debugger menu
    use {'nvim-telescope/telescope.nvim',
          config = function() require('ex.telescope') end,
          requires = {
              {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
              'nvim-telescope/telescope-file-browser.nvim',
              'nvim-telescope/telescope-dap.nvim',
              'nvim-lua/plenary.nvim',
          },
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

    -- git
    use { 'TimUntersberger/neogit',
          requires = { 'nvim-lua/plenary.nvim', },
          config = function() require('ex.neogit') end
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

    -- utils
    use {
        "windwp/nvim-autopairs", -- autopairs, html autotagging
        requires = { "windwp/nvim-ts-autotag" },
        config = function() require('ex.pair') end,
    }

    use {
        "numToStr/Comment.nvim", -- comment lines of code
        config = function() require('ex.comment') end,
    }

    -- markdown
    use {
        'iamcco/markdown-preview.nvim',
        config  = function() require('ex.markdown') end,
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
