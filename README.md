<h1 align="center">dotfiles</h1>
<p align="center">
    Personal dotfiles and system setup automation.
</p>
<br>

<p><div align="center" width="100%">

OS | Terminal | Editor | Shell
---|---|---|---
[macOS](https://www.apple.com)/[Ubuntu](https://ubuntu.com/download)| [ghostty](https://ghostty.org)/[tmux](http://linuxcommand.org/lc3_man_pages/tmux1.html) | [neovim](https://github.com/neovim/neovim) | [zsh](https://www.zsh.org)

</div></p>

## 1. Installation

Clone the repo with its submodules (`~/.config/crew` is a submodule), then run
the installer:

```bash
git clone --recurse-submodules git@github.com:duclos-cavalcanti/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

Already cloned without `--recurse-submodules`? Pull them in with:

```bash
git submodule update --init --recursive
```

## 2. Tools

- **fzf**
- **ripgrep**
- **fd** _(find)_
- **eza** _(ls)_
- **bat** _(cat)_

## 3. Theming

Theme schemes are YAML in `theme/` (repo root, not stowed) — the source library.
Each scheme carries two blocks (see `theme/andromeda.yaml`, the exemplar):

- **terminal** — the 16 ANSI colors + UI (`background`/`foreground`/`cursor`/
  `selection-*`), copied *verbatim* from the source theme. Consumed by ghostty.
- **base16** — `base00`–`base0F` for nvim (mini.base16): a mix of direct copies
  from the 16 above and inferred slots (ramp steps + `base09`/`base0F`, which
  have no ANSI equivalent).

Both nvim and ghostty consume one active slot named `custom`; switch schemes by
re-emitting a scheme into that slot with the `base16` generator, then reload:

```bash
base16 lua     <scheme> > ~/.config/nvim/lua/theme/custom.lua   # base16 block
base16 ghostty <scheme> > ~/.config/ghostty/themes/custom       # terminal block
```

To seed a new scheme's terminal block, inspect any built-in ghostty theme's 16
palette values (`ghostty +list-themes` to browse names):

```bash
cat /Applications/Ghostty.app/Contents/Resources/ghostty/themes/<name>
```

## 4. License

Released under the MIT license. See [LICENSE](LICENSE).

---
<p align="center">
<a href="LICENSE">
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" />
</a>
<a>
  <img src="https://img.shields.io/github/languages/code-size/duclos-cavalcanti/dotfiles.svg" />
</a>
<a>
  <img src="https://img.shields.io/github/commit-activity/m/duclos-cavalcanti/dotfiles.svg" />
</a>
</p>
