<h1 align="center">(mac)files</h1>
<p align="center">
    Personal dotfiles and system setup automation.
</p>
<br>

<p><div align="center" width="100%">

OS | AI | Terminal | Editor | Shell
---|---|---|---|---
[macOS](https://www.apple.com)| [claude](https://platform.claude.com/docs/en/home) | [cmux](https://cmux.com/)/[tmux](http://linuxcommand.org/lc3_man_pages/tmux1.html) | [neovim](https://github.com/neovim/neovim) | [zsh](https://www.zsh.org)

</div></p>

## 1. Installation

```bash
./install.sh
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
# then reload: ghostty reload-config keybind; nvim restart (or re-source)
```
