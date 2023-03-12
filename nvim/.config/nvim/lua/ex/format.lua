local util = require "formatter.util"

require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    html = {
        -- npm install --save-dev --save-exact prettier
        function()
            return {
                exe = "npx prettier",
                args = {
                    "--stdin-filepath",
                    util.escape_path(util.get_current_buffer_file_path()),
                },
                stdin=true
            }
        end
    },

    -- Use the special "*" filetype for any filetype
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}
