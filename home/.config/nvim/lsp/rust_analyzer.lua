-- Base config for rust-analyzer, direct on the core LSP client (no
-- nvim-lspconfig). `vim.lsp.enable("rust_analyzer")` finds this file on the
-- runtimepath and uses it as the base; `after/lsp/rust_analyzer.lua` merges
-- overrides on top.
--
-- This is the minimal honest base: enough to launch and attach. lspconfig's
-- version additionally runs `cargo metadata` async to resolve the true
-- workspace root for multi-crate workspaces (a member crate attaches at the
-- workspace, not the member). root_markers stops at the nearest Cargo.toml,
-- which is correct for single-crate repos and "good enough" for most.

---@type vim.lsp.Config
return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },

  -- rust-analyzer expects its settings echoed into initializationOptions
  -- rather than only sent via workspace/didChangeConfiguration.
  before_init = function(params, config)
    local settings = config.settings and config.settings["rust-analyzer"]
    if settings then
      params.initializationOptions = settings
    end
  end,
}
