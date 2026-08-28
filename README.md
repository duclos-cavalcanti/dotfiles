<h1 align="center">(mac)files</h1>
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

base16 schemes are YAML in `theme/` (repo root, not stowed) — the source library.
Both nvim and ghostty consume one active slot named `custom`; switch schemes by
re-emitting any scheme into that slot with the `base16` generator, then reload:

```bash
base16 lua     <scheme> > ~/.config/nvim/lua/theme/custom.lua
base16 ghostty <scheme> > ~/.config/ghostty/themes/custom
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
