-- loads all configs

require("globals")
require("settings")
require("keys")
require("commands")
require("plugins")
require("theme")

-- vim.opt.runtimepath:append("$HOME/.config/nvim/pack/plugins/start/example")
-- require("example").setup({})

-- treesitter issue 
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/3092

-- local args = vim.fn.argv()
-- if args[1] == "g" then
--     vim.cmd[["execute ':Neogit'"]]
-- end
