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
    { -- treesitter
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        dependencies = {
            "windwp/nvim-ts-autotag",
        },
        config = function()
            require("nvim-treesitter").install({
                "bash", "html", "javascript", "css", "c", "c_sharp", "cpp",
                "cmake", "make", "rust", "python", "lua", "commonlisp",
                "haskell", "go", "nix", "gomod", "gowork", "java", "json",
                "yaml", "vim", "vimdoc", "query", "latex",
            })

            require("nvim-ts-autotag").setup()

            -- main branch drops plugin highlighting; enable core TS per buffer.
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },
    { -- lsp, completion, and snippets
        "neovim/nvim-lspconfig",
        -- event = "InsertEnter",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require'cmp'
            local ls = require "luasnip"

            vim.lsp.set_log_level 'info'
            vim.diagnostic.config({ virtual_text = false })

            vim.o.updatetime = 250
            vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

            vim.lsp.config('*', {
              capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(args)
                    local bufnr = args.buf
                    local opts = {noremap = true, silent = false}

                    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                    vim.api.nvim_buf_set_keymap(bufnr, 'n', "gd",        "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', "gD",        "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', "gi",        "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', "gh",        "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', "GT",        "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', "K",         "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', "<leader>R", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', "gn",        "<Cmd>lua vim.diagnostic.goto_next()<CR>", opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', "gp",        "<Cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', "gf",        "<Cmd>lua vim.diagnostic.open_float()<CR>", opts)
                end,
            })

            vim.lsp.enable('clangd')
            vim.lsp.enable('gopls')
            vim.lsp.enable('metals')
            vim.lsp.enable('marksman')
            vim.lsp.enable('csharp_ls')
            vim.lsp.enable('denols')
            vim.lsp.enable('rust_analyzer')
            vim.lsp.enable('cssls')
            vim.lsp.enable('html')
            vim.lsp.enable('pyright')
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('yamlls')
            vim.lsp.enable('bashls')

            ls.config.set_config {
                history = true,
                updateevents = "TextChanged,TextChangedI",
                enable_autosnippets = true,
            }
            ls.cleanup()
            -- read snippets lazily from the snippets folder besides init.lua
            require("luasnip.loaders.from_snipmate").lazy_load()
            -- examples inspired by
            -- https://github.com/honza/vim-snippets/tree/master/snippets

            cmp.setup({
                snippet = {
                    expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- luasnip users.
                  end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
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
        end,
    },
    { -- Misc.
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@type snacks.Config
      opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = true },
        gitbrowse = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = {
          enabled = false,
          timeout = 3000,
        },
        picker = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        styles = {
          notification = {
            -- wo = { wrap = true } -- Wrap notifications
          }
        }
      },
      keys = {
        -- Top Pickers & Explorer
        { "<leader>sf", function() Snacks.picker.files({ hidden = true }) end, desc = "Find Files" },
        { "<leader>sb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
        { "<leader>sbd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        { "<leader>sbr", function() Snacks.rename.rename_file() end, desc = "Rename File" },
        { "<leader>sl", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
        { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
        { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
        { "<leader>sL", function() Snacks.picker.loclist() end, desc = "Location List" },
        { "<leader>sQ", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
        { "<leader>sm", function() Snacks.picker.man() end, desc = "Man Pages" },
        { "<leader>sM", function() Snacks.picker.marks() end, desc = "Marks" },

        { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
        { "<leader>E", function() vim.cmd("tabnew") Snacks.explorer({ layout = { layout = { width = 0, height = 0 } } }) end, desc = "File Explorer (Fullscreen, New Tab)" },

        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
        { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },

        { "<leader><Tab>", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
        { "<leader><S-Tab>", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

        { "<leader>Z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
        { "<leader>z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },

        { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },

        { "<leader>gy", function() Snacks.gitbrowse() end, desc = "Git Browse (open in remote)", mode = { "n", "v" } },
      },
      init = function()
        vim.api.nvim_create_autocmd("User", {
          pattern = "VeryLazy",
          callback = function()
            -- Setup some globals for debugging (lazy-loaded)
            _G.dd = function(...)
              Snacks.debug.inspect(...)
            end
            _G.bt = function()
              Snacks.debug.backtrace()
            end

            -- Override print to use snacks for `:=` command
            if vim.fn.has("nvim-0.11") == 1 then
              vim._print = function(_, ...)
                dd(...)
              end
            else
              vim.print = _G.dd
            end
          end,
        })
      end,
    },
    { -- themes/ui
        "projekt0n/github-nvim-theme",
        name = 'github-theme',
        lazy = false,
        priority = 1000,
        dependencies = {
                "fneu/breezy",
                "nvim-lualine/lualine.nvim",
                'kyazdani42/nvim-web-devicons',
                {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
                { "olimorris/onedarkpro.nvim", priority = 1000, },
                { "srcery-colors/srcery-vim", lazy = false, priority = 1000, },
                -- nvim-colorizer.lua needs truecolor (termguicolors). nightfox runs
                -- truecolor, so this can be re-enabled if you want inline color swatches.
                -- {
                --     'norcalli/nvim-colorizer.lua',
                --     config  = function() require('colorizer').setup() end,
                -- },
        },
        config = function()
            vim.opt.termguicolors = true
            -- vim.o.background = "light"
            vim.cmd([[colorscheme github_dark_default]])

            require("bufferline").setup {
                options = {
                    mode = "tabs",
                    show_duplicate_prefix = false,
                }
            }

            -- statusline
            require('lualine').setup {
                options = {
                    theme = 'auto',
                    component_separators = {left = '', right = ''},
                    section_separators = {left = '', right = ''},
                    disabled_filetypes = {},
                    always_divide_middle = true,
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = { {'filename', path = 1}, 'diff'},
                    lualine_c = {{'branch'}, },
                    lualine_x = {'location'},
                    lualine_y = {'progress'},
                    lualine_z = {'filetype'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                extensions = {}
            }
        end,
    },
    { -- utils
        { 'diogo464/hotreload.nvim', opts = {} },
        { "windwp/nvim-autopairs", config = function() require('nvim-autopairs').setup({}) end, },
        { "numToStr/Comment.nvim", config = function() require('Comment').setup() end, },
        { "fei6409/log-highlight.nvim", config = function() require("log-highlight").setup {} end, },
        { -- gitsigns: git gutter signs + line-level blame
            "lewis6991/gitsigns.nvim",
            event = { "BufReadPre", "BufNewFile" },
            opts = {
                current_line_blame = true, -- inline "who/when" on the current line
                current_line_blame_opts = { delay = 250, virt_text_pos = "eol" },
                on_attach = function(bufnr)
                    local gs = require("gitsigns")
                    local function map(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                    end
                    -- hunk navigation
                    map("n", "]h", function() gs.nav_hunk("next") end, "Next git hunk")
                    map("n", "[h", function() gs.nav_hunk("prev") end, "Prev git hunk")
                    -- blame / history
                    map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line (full popup)")
                    map("n", "<leader>gB", function() gs.blame() end, "Blame whole file")
                    map("n", "<leader>gp", gs.preview_hunk, "Preview hunk diff")
                    map("n", "<leader>gt", gs.toggle_current_line_blame, "Toggle inline line blame")
                end,
            },
        },
        {
            "esmuellert/codediff.nvim",
            cmd = "CodeDiff",
            opts = {},
            keys = {
                { "<leader>cd", "<cmd>CodeDiff<CR>", desc = "CodeDiff (changed files)" },
                {
                    "<leader>cD",
                    function()
                        local cur = vim.api.nvim_get_current_win()
                        local files = {}
                        for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                            -- only count real file windows (skip trees, floats, etc.)
                            if vim.bo[vim.api.nvim_win_get_buf(w)].buftype == "" then
                                table.insert(files, w)
                            end
                        end
                        if #files ~= 2 then
                            vim.notify("Need exactly two file windows open", vim.log.levels.WARN)
                            return
                        end
                        local other = files[1] == cur and files[2] or files[1]
                        local a = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(cur))
                        local b = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(other))
                        if a == "" or b == "" then
                            vim.notify("Both windows must hold saved files", vim.log.levels.WARN)
                            return
                        end
                        vim.cmd(("CodeDiff file %s %s"):format(vim.fn.fnameescape(a), vim.fn.fnameescape(b)))
                    end,
                    desc = "CodeDiff (two open windows)",
                },
            },
        },
    },
    { -- local
        {
            dir = vim.fn.stdpath("config") .. "/pack/plugins/start/agentic",
            name = "agentic",
            lazy = true,
            keys = {
                { "<C-g>f", "<cmd>AgenticSendFile<CR>", desc = "Send file ref to agent" },
                { "<C-g>i", ":<C-u>AgenticSendSelection<CR>", mode = "x", desc = "Send selection ref to agent" },
                { "<C-g>r", "<cmd>AgenticRegister<CR>", desc = "Register a tmux session for the agent" },
            },
            config = function()
                require("agentic").setup()
            end,
        },
    },
}

local opts = {

}

require("lazy").setup(plugins, opts)
