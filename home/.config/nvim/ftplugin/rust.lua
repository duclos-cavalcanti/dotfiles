-- :make runs cargo via the built-in compiler/cargo.vim (sets makeprg +
-- rustc errorformat -> quickfix). Use :make build | test | clippy | run.
vim.cmd [[compiler cargo]]
