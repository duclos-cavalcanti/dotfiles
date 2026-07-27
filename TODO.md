# TODO — macfiles workflow improvements

Workflow improvements for `cmux` + `ghostty` + macfiles. cmux owns the GUI shell (windows, tabs, splits, menus, palette, keybinds, notifications); ghostty is the cell renderer only (theme, font, cursor, padding, shell integration, conditional blocks).

Refs: [cmux docs](https://cmux.com/docs) · [ghostty docs](https://ghostty.org/docs) · local dumps: `cmux capabilities`, `ghostty +show-config --default --docs`, `ghostty +list-keybinds --default`.

## Fix first

- [x] Ghostty config: fix bare `Adwaita Dark` line missing `theme = ` prefix (silent parse error).

## Agentic / Claude Code

- [ ] Replace `cmux send` in `agentic/cmux.lua` with `cmux rpc workspace.prompt_submit` (safer bracketed-paste; confirm schema via `cmux capabilities`).
- [ ] Emit OSC 9 / OSC 777 from `home/.claude/scripts/{start,prompt,notif,stop}-signal.sh` for native ghostty notifications; set `desktop-notifications = true`.
- [ ] Resolve dead agentic-signal subsystem: the 4 `home/.cmux/agentic/*-signal.sh` backends are removed. Remaining: the 4 `home/.claude/scripts/*-signal.sh` orchestrators are `exit 0` no-ops (dispatch lines commented out, referencing a nonexistent `~/.tmux/agentic/` and the now-deleted `~/.cmux/agentic/`); `settings.json` fires all four as hooks for zero effect; `statusline.sh` consumes no signal. Either build it (the OSC 9/777 item above) or delete the 4 orchestrators + 4 hook blocks.
- [x] Add `:AgenticPreview [path]` live markdown preview via `cmux markdown open` to `agentic/init.lua`.
- [ ] Pin + color the daily-driver claude surface (`cmux tab-action --action pin` + `cmux workspace-action --action set-color`).
- [ ] Try `cmux feed tui` — permission-arbitration sidebar panel (`ctrl+4`).
- [ ] Try `cmux omc team 3:claude "implement X"` multi-agent orchestrator on a parallelizable task.

## Navigation / search

- [ ] Bind `cmux find-window --content --select "<query>"` (content search across all surfaces) to an alias/keybind.

## Appearance / themes

- [ ] Add per-appearance ghostty `[appearance=dark]` / `[appearance=light]` conditional blocks (padding-color, minimum-contrast).
- [ ] Add `font-codepoint-map = U+E000-U+F8FF=Symbols Nerd Font Mono` for icon-font glyph routing.
- [ ] Switch ghostty to light/dark auto-switch theme: `theme = light:Adwaita,dark:Adwaita Dark`.
- [ ] `base16` script: adopt `yq` (add to Brewfile) to parse base16 schemes and pull them directly from upstream GitHub unmodified — `tinted-theming/schemes` (canonical, nested `palette:` format) and legacy `tinted-theming/base16-schemes` (flat). Would replace the awk flat-format parser and drop the manual flatten step. Trade-off: +1 dependency vs awk's zero-install POSIX surface — only worth it if consuming upstream schemes regularly.

## Shell integration & performance

- [ ] Set ghostty `shell-integration = detect` and `shell-integration-features = cursor,sudo,title,ssh-env,ssh-terminfo`.
- [ ] Add optional host-specific include `config-file = ?work.conf` to ghostty config.
- [ ] Run `cmux config doctor` once and fix flagged keys in `cmux.json`.

## Workflow / dotfiles polish

- [ ] Set up `~/.config/cmux/dock.json` to pin TUIs (lazygit, log tail, test watcher) to the sidebar.
- [x] Delete `home/.scripts/example.sh` — duplicated the `^Xt` → `fzf-tmux-sessions` zsh binding (DRY). Removed `.scripts` entirely; personal scripts now live in `home/.bin` (already on PATH).
- [ ] Delete dead macOS Terminal.app profile `home/.config/terminal/profile.terminal` (8.7k, referenced nowhere; the stack is ghostty + cmux) — unless kept as a deliberate fallback, in which case add a note saying why.

## Neovim / trim toward core

Track the NEOVIM.md thesis ("native core eats plugins") against the actual `home/.config/nvim` config, which still runs the older stack.

- [ ] Replace completion stack `nvim-cmp` + the six `cmp-*` sources + `cmp_luasnip` (7 packages in `lua/plugins.lua`) with `blink.cmp` (1 package) — the LazyVim/kickstart default per NEOVIM.md.
- [x] ~~Drop `nvim-lspconfig`~~ **Kept as a data provider** (decided during vim.pack port). The native 0.11 path is in use (`vim.lsp.enable()` + `lsp/*.lua`), but the `lsp/*.lua` are NOT self-contained: 8/13 servers (denols, csharp_ls, metals, marksman, cssls, html = `return {}`; yamlls, bashls = no file; rust_analyzer = settings-only; clangd = cmd-only) rely on lspconfig's bundled `lsp/<name>.lua` for `cmd`/`filetypes`/root markers, merged under our overrides. Fully dropping it = hand-writing defs + root-dir detection for all 13 — not worth it. On 0.11+ lspconfig is just a definitions package feeding core, so keeping it is still "toward core".
- [ ] Migrate plugin manager `lazy.nvim` → native `vim.pack` (0.12) with lockfile (bigger lift; per NEOVIM.md + echasnovski's vim.pack guide).
- [ ] Remove dead colorscheme `gruvbox.nvim`: it's the top-level theme spec (priority 1000) in `lua/plugins.lua` but `colorscheme adwaita` is what gets set, so gruvbox never activates. Promote adwaita to the parent spec, delete gruvbox.
- [ ] Collapse duplicate devicons in `lua/plugins.lua`: both `kyazdani42/nvim-web-devicons` (stale, moved repo) and `nvim-tree/nvim-web-devicons` are listed — same plugin. Keep `nvim-tree/...`.
- [ ] Fix double-managed `agentic` plugin: it lives in `pack/plugins/start/agentic` (auto-sourced natively by nvim at startup) *and* is registered in `lua/plugins.lua` via lazy with `dir=` + `lazy=true`. Pick one — move it to `pack/plugins/opt/` so only lazy loads it, or drop the lazy spec and let pack own it.

### Org ideas from orcnvim (zootedb0t)

- [ ] Move per-filetype settings out of `FileType` autocmds in `autocmds.lua` into core-native `after/ftplugin/<ft>.lua` files (Neovim auto-loads by filetype; filename is the trigger, no autocmd). More core, less indirection — aligns with the "toward core" thesis. Ref: `orcnvim/after/ftplugin/markdown.lua` (`vim.opt_local.spell = true`). Worth it once there's >1 per-ft tweak.
- [ ] Consider namespacing the config modules under a user dir (`lua/<ns>/…`, e.g. `require("<ns>.config")`) so generic names (`config`, `utils`) can't collide with a plugin module on the runtimepath. Trade-off: more nesting for a collision that may never bite. Ref: `orcnvim/lua/orcnvim/`.
- [ ] Minor: use tiered `root_markers` in `lsp/*.lua` (nested table = same-priority tier before fallback), e.g. `root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" }` (0.11 feature). Ref: `orcnvim/after/lsp/lua_ls.lua`.

## Ideas / TBD

- [ ] _add your own here_
