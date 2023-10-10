<h1 align="center">(dot)files</h1>
<p align="center">
  Personal config files used on my linux daily-driver 
</p>
<br>

<div align="center" width="100%">

OS | WM | Terminal | Editor | Shell
---|---|---|---|---
[nixos/](https://nixos.org/)[ubuntu](https://ubuntu.com/) | [awesome](https://github.com/awesomeWM/awesome) + [picom](https://github.com/yshui/picom) + [wallpapers](https://github.com/ubuntu-mate/ubuntu-mate-artwork) | [wezterm](https://github.com/wez/wezterm) | [neovim](https://github.com/neovim/neovim) | [bash](https://www.gnu.org/software/bash/)

</div>


## Installation
### NixOS
<p>
  <img alt="NixOS" src="https://img.shields.io/badge/nixos-5277C3.svg" />
</p>

A linux distribution based on the [nix](https://nixos.org/) package manager, who enables a __declarative__ and __reproducible__ 
build system. When the system is built, a configuration file is generated which states every aspect of the operating 
system. It is a very powerful system, enables easy self-packaging of projects, sandboxed environments, infrastructure as code 
to define multiple systems, and so many more. It is my system of choice and the steps below are to be done in case 
you would like to try my system out!

#### Steps

0. Burn USB with [nix-os](https://nixos.org/) image.
1. Connect to WiFi if needed. [_(Example)_](https://gist.github.com/duclos-cavalcanti/07a35299de7e095052562ea9ef492b6d)
2. Partition filesystem. [_(Example)_](https://gist.github.com/duclos-cavalcanti/e78ea4c665cdd3bb814b6fb57db68dc4)
3. Run
```sh
nix --experimental-features 'nix-command flakes' run github:duclos-cavalcanti/dotfiles#flake
```

### Ubuntu __(deprecated)__
<p>
  <img alt="Ubuntu" src="https://img.shields.io/badge/ubuntu-red.svg" />
</p>

<div align="center">
  <img src=".github/assets/screen.png?" width="85%" align="center"/>
</div>

#### Steps
- burn USB with [ubuntu-server](https://www.releases.ubuntu.com/jammy/) image
- Run: 
  ```bash
  curl \
  https://raw.githubusercontent.com/duclos-cavalcanti/dotfiles/ubuntu/install.sh | bash
  ```

<div align="center">
  <img src=".github/assets/deploy.png" width="80%" align="center"/>
</div>

To avoid the annoying cloud-init output pollution as per this 
[issue](https://askubuntu.com/questions/1333240/ubuntu-20-04-server-blocks-at-boot-cloud-init-and-login),
simply create the `/etc/cloud/cloud-init.disabled` file afterwards.


## License
These dotfiles are released under the MIT license. See [LICENSE](LICENSE).

## Donations
I have a ko-fi and a buy-me-a-coffee account, so if you found this repo useful and would like to show your appreciation, feel free to do so!

<p align="center">
<a href="https://ko-fi.com/duclos">
<img src="https://img.shields.io/badge/donation-ko--fi-red.svg">
</a>

<a href="https://www.buymeacoffee.com/danielduclos">
<img src="https://img.shields.io/badge/donation-buy--me--coffee-green.svg">
</a>

</p>

---
<p align="center">
<a href="https://github.com/duclos-cavalcanti/templates/LICENSE">
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" />
</a>
<a>
  <img src="https://img.shields.io/github/languages/code-size/duclos-cavalcanti/dotfiles.svg" />
</a>
<a>
  <img src="https://img.shields.io/github/commit-activity/m/duclos-cavalcanti/dotfiles.svg" />
</a>
</p>
