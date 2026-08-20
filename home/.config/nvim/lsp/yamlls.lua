-- Base config for yaml-language-server, direct on the core LSP client.
return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
  root_markers = { ".git" },
  settings = {
    redhat = { telemetry = { enabled = false } },
    -- yaml-language-server disables formatting by default; turn it on.
    yaml = { format = { enable = true } },
  },
}
