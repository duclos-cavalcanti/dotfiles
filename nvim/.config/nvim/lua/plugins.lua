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
        config = function() require('plugins.lspconfig') end,
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
        config = function() require('plugins.completion') end,
      }

    -- finder
    use {'nvim-telescope/telescope.nvim',
          config = function() require('plugins.telescope') end,
          requires = {
              {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
              'nvim-telescope/telescope-dap.nvim',
              'nvim-lua/plenary.nvim',
          },
      }

    -- treesitter
    use { "nvim-treesitter/nvim-treesitter",
          config = function() require('plugins.treesitter') end,
          run = ":TSUpdate", }

    -- debugger
    use { "mfussenegger/nvim-dap",
          config = function() require('plugins.debugger') end,
      }

    -- java specific lsp and debugger options integrating with nvim-dap
    use { "mfussenegger/nvim-jdtls", requires = {"mfussenegger/nvim-dap"} }

    -- debugger ui
    use { "rcarriga/nvim-dap-ui",
           config = function() require("plugins.debugger-ui") end,
           requires = {"mfussenegger/nvim-dap"} }

    -- file explorer
    use { 'kyazdani42/nvim-tree.lua',
          requires = { 'kyazdani42/nvim-web-devicons', },
          config = function() require('plugins.nvim-tree') end
        }

    -- tagsbar / tags outliner
    use { 'simrat39/symbols-outline.nvim',
          config = function() require('plugins.tagsbar') end
        }

    -- git
    use { 'TimUntersberger/neogit',
          requires = { 'nvim-lua/plenary.nvim', },
          config = function() require('plugins.neogit') end
        }

    -- snippets
    use {
        "L3MON4D3/LuaSnip",
        config = function()
            local s = require('plugins.luasnip')
            s.config()
            s.setup()
        end
    }

    -- utils
    use {
        "windwp/nvim-autopairs", -- autopairs
        config = function() require('plugins.pair') end,
    }

    use {
        "p00f/nvim-ts-rainbow", -- rainbow parenthesis
    }

    use {
        "numToStr/Comment.nvim", -- comment lines of code
        config = function() require('plugins.comment') end,
    }

    -- markdown
    use {
        'iamcco/markdown-preview.nvim',
        config  = function() require('plugins.markdown') end,
    }

    -- common lisp
    use {
        'jpalardy/vim-slime',
        config  = function() require('plugins.slime') end,
    }

    -- themes/ui
    use { 'nvim-lualine/lualine.nvim',
          requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }

    use 'rockerBOO/boo-colorscheme-nvim'

    -- view colors in nvim
    use { 'norcalli/nvim-colorizer.lua',
           config  = function() require('colorizer').setup() end,
        }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
