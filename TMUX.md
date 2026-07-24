# TMUX — modularization notes

Living snapshot of how tmux configs are (and aren't) worth splitting up, and the
decision for this repo. Last reviewed: 2026-07.

## The mechanism (and its ceiling)

tmux has exactly **one** include mechanism — `source-file <path>` — and **no**
module system, namespacing, or import. The main config sources topic files; that
is the whole toolkit.

**The trap:** user variables/options do **not** reliably carry across sourced
files. Per `samoshkin/tmux-config` (the most-cited detailed modular config):

> "variables are not extracted to a dedicated file … because tmux does not see
> variable values after sourcing `theme.conf`."

So each sourced `.conf` must be **self-contained** option-setting — you can't
factor shared values into one file and reference them from another the way nvim
lua modules share state. tmux modularization is coarse by nature.

## What power users actually do

1. **XDG dir + topic files.** `~/.config/tmux/tmux.conf` sources siblings:
   `theme.conf` (near-universal), sometimes `options.conf`, `keybindings.conf`,
   `plugins.conf`. (`~/.config/tmux/` is the modern location vs legacy
   `~/.tmux.conf`.)
2. **Theme is the usual — often only — split.** e.g. alexforsale = `tmux.conf`
   + `nord.conf`; even samoshkin keeps most in one file + a theme file.
3. **Conditional includes** for host/remote:
   `if-shell '<cond>' 'source-file ~/.config/tmux/remote.conf'`
   (same version-guard idiom used for the crew statusline).
4. **Logic → external scripts; tmux just wires.** The cleanest "modularization":
   anything with logic lives in a script called via `#(...)` / `run-shell`,
   not crammed into `.conf`.
5. **Many stay flat/single-file on purpose** — portability (`scp` one file to a
   remote box), the "keep it vanilla" ethos.

## Decision for this repo

Our `.tmux.conf` is ~120 lines and coherent, and the high-value modularization is
**already done via scripts**: `~/.config/crew/` (registry + sidebar + statusline
emitter), `~/.bin/{sysinfo,nvim-difftool}` — tmux calls them through `#(...)` /
`run-shell`. That's pattern #4, the real win.

Given tmux's coarse `source-file` + the variable limitation, file-splitting a
small, legible config has **diminishing returns** (no clean module payoff like
nvim). So:

- **Stay mostly flat.** Keep logic in scripts, not `.conf`.
- **Extract `theme.conf` only if** the appearance/status block keeps growing —
  it's the natural first (and probably only) split.
- **XDG migration** (`~/.tmux.conf` → `~/.config/tmux/tmux.conf`) is optional;
  do it if/when we split, since it pairs with a modular dir.

Not fragmenting the config for its own sake — revisit if it outgrows one screen.

## Sources

- [samoshkin/tmux-config](https://github.com/samoshkin/tmux-config) — modular + the variable caveat
- [alexforsale dotfiles-tmux](https://alexforsale.github.io/dotfiles-tmux/) — minimal `tmux.conf` + `nord.conf`
- [christoomey/dotfiles](https://github.com/christoomey/dotfiles/blob/master/tmux/tmux.conf)
- [thevaluable.dev — Writing Your tmux Config](https://thevaluable.dev/tmux-config-mouseless/)
