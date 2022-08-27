local actions = require('telescope.actions')

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
    },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('dap')
