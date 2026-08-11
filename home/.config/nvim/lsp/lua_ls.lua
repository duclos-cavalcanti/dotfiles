-- Base config for lua-language-server, direct on the core LSP client.
-- Tuned for editing Neovim config: makes `vim`/`root` known globals and
-- pulls the Neovim runtime into the workspace library.
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml", ".git" },
  single_file_support = true,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT", -- Neovim embeds LuaJIT, not Lua 5.4
        path = runtime_path,
      },
      diagnostics = {
        globals = { "vim", "root" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
