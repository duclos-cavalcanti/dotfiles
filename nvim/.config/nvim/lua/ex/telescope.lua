local actions = require('telescope.actions')
local fb_actions = require("telescope").extensions.file_browser.actions

require('telescope').setup({
  defaults = {
    sorting_strategy = "ascending",
    mappings = {
      i = {
        ['<C-n>'] = actions.move_selection_next,
        ['<C-p>'] = actions.move_selection_previous,
        ['<C-c>'] = actions.close,
      },
      n = {
        ['<C-c>'] = actions.close,
      },
    },
    layout_config = {
      horizontal ={
        height = 47,
        prompt_position = "top",
      }
    }
  },
  extensions ={
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      },
    file_browser = {
      -- theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
            -- Tab and S-Tab select options
            ['<A-c>'] = fb_actions.create,
            ['<A-r>'] = fb_actions.rename,
            ['<A-y>'] = fb_actions.copy,
            ['<A-d>'] = fb_actions.remove,
            ['<C-o>'] = fb_actions.open,
            ['<C-g>'] = fb_actions.goto_parent_dir,
            ['<C-e>'] = fb_actions.goto_home_dir,
            ['<C-w>'] = fb_actions.change_cwd,
            ['<C-f>'] = fb_actions.toggle_browser,
            ['<C-h>'] = fb_actions.toggle_hidden,
        },
        ["n"] = {
            ['<C-c>'] = actions.close,
        },
      },
    },
  },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('dap')
require("telescope").load_extension("file_browser")
