local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  settings = {
    runtime = {
      version = 'Lua 5.4',
      path = runtime_path
    },
    diagnostics = {
      globals = {
        "vim",
        "root"
      },
    },
    workspace = {
      library = {
        vim.api.nvim_get_runtime_file("", true),
        "/usr/share/awesome/lib",
      }
    },
    telemetry = {
      enable = false
    },
  },
  single_file_support = true,
}
