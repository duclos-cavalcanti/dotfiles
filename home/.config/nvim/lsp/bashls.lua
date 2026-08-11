-- Base config for bash-language-server, direct on the core LSP client.
return {
  cmd = { "bash-language-server", "start" },
  filetypes = { "bash", "sh" },
  root_markers = { ".git" },
  settings = {
    bashIde = {
      -- Non-recursive glob: scanning "**/*" breaks when a shell file is
      -- opened directly in $HOME (walks the whole home tree).
      globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
    },
  },
}
