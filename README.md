# NixConf

My personal [NixOS](https://nixos.org) configuration using [Home Manager](https://github.com/nix-community/home-manager) and [SOPS](https://getsops.io) as a flake module.

Contains several profiles including [minimal.nix](https://github.com/luantorv/nixconf/tree/main/profiles/minimal.nix) (CLI/TUI only), [river.nix](https://github.com/luantorv/nixconf/tree/main/profiles/river.nix) and [niri.nix](https://github.com/luantorv/nixconf/tree/main/profiles/niri.nix) with different graphical configurations.

## Structure

```sh
.
├── assets/            # Wallpapers and screenshots
├── docs/              # Configuration documentation
│   ├── INSTALLATION and UPDATING.md
│   ├── KEYBINDS.md
│   └── SECRETS.md
├── flake.nix          # Entry point, global variables
├── hosts/             # Per-machine configuration
│   ├── laptop/
│   │   ├── default.nix
│   │   ├── boot.nix
│   │   ├── hardware-configuration.nix
│   │   └── hardware.nix
│   └── server/
│       ├── default.nix
│       ├── boot.nix
│       ├── hardware-configuration.nix
│       └── harwdare.nix
├── modules/
│   ├── home/          # Home Manager modules
│   │   ├── desktop/
│   │   ├── editors/
│   │   ├── files/
│   │   ├── hypr/
│   │   ├── packages/
│   │   ├── river/
│   │   ├── shell/
│   │   ├── terminal/
│   │   └── theme/
│   └── nixos/         # NixOS modules
│       ├── boot/
│       └── core/
├── profiles/          # Module bundles per use case
│   ├── minimal.nix
│   ├── niri.nix
│   └── river.nix
├── secrets/           # Secrets handled by SOPS
├── CREDITS.md
└── README.md
```

## Profiles

### Minimal

| Components |  |
|---|---|
| WM/DE | TTY (CLI/TUI only) |
| Shell | [Bash](https://www.gnu.org/software/bash/) |
| Editor | [NeoVim](https://neovim.io/) |
| File Manager | [yazi](https://github.com/sxyazi/yazi) |
| System Monitor | [btop](https://github.com/aristocratos/btop) |
| Fetch | [fastfetch](https://github.com/fastfetch-cli/fastfetch) - [onefetch](https://github.com/o2sh/onefetch) |
| CLI Utilities | [atuin](https://github.com/atuinsh/atuin) - [zoxide](https://github.com/ajeetdsouza/zoxide) - [eza](https://github.com/eza-community/eza) - [fzf](https://github.com/junegunn/fzf) - [bat](https://github.com/sharkdp/bat) - [fd](https://github.com/sharkdp/fd) - [ripgrep](https://github.com/BurntSushi/ripgrep) |
| TUI tools| [lazygit](https://github.com/jesseduffield/lazygit) - [lazydocker](https://github.com/jesseduffield/lazydocker) |

### Desktop

> Isn't a profile, but is the common packages and modules for graphical profiles (with GUIs).

| Components | |
|---|---|
| Editors | [NeoVim](https://neovim.io/) - [VSCodium](https://vscodium.com/) |
| File Managers | [yazi](https://github.com/sxyazi/yazi) - [Thunar](https://gitlab.xfce.org/xfce/thunar) |
| Calendar | [Orage](https://gitlab.xfce.org/apps/orage) |
| Browser | [Brave](https://brave.com/) |
| Office Suite | [OnlyOffice](https://www.onlyoffice.com/) |
| GUI Dev Tools | [DBeaver]() - [Boxes]() |
| Brightness Control | [brightnessctl](https://github.com/Hummer12007/brightnessctl) |
| Media Tools | [mpv](https://mpv.io) - [nomacs](https://nomacs.org) - [zathura](https://pwnet.org/projects/zathura) |
| Sound | [pamixer](https://github.com/cdemoulins/pamixer) - [playerctl](https://github.com/acrisci/playerctl) |
| Screenshoot Tools | [grim](https://gitlab.freedesktop..org/emersion/grim) - [slurp](https://github.com/emersion/slurp) - [swappy](hhtps://github.com/jtheoof/swappy) |
| Clipboard | [wl-clipboard](https://github.com/bugaevc/wl-clipboard) - [cliphist](https://github.com/sentriz/cliphist) |
| Game Apps | [Steam](https://store.steampowered.com) - [Discord](https://discordapp.com) - [PrismLauncher](https://prismlauncher.org) |

### River

<div align="center">
  <img src="assets/screenshoots/foot-fastfetch.png" alt="Fastfetch" width="45%">
  <img src="assets/screenshoots/waybar.png" alt="Waybar" width="45%">
  <img src="assets/screenshoots/wofi.png" alt="Wofi launcher" width="45%">
  <img src="assets/screenshoots/wofi-energy_menu.png" alt="Wofi power menu" width="45%">
  <img src="assets/screenshoots/nvim.png" alt="Vim" width="45%">
  <img src="assets/screenshoots/btop.png" alt="Htop" width="45%">
</div>

| Components |  |
|---|---|
| WM | [River (wayland)](https://codeberg.org/river/river-classic) |
| Terminal | [Foot](https://codeberg.org/dnkl/foot/) |
| Shell | [Bash](https://www.gnu.org/software/bash/) |
| Status Bar | [waybar](https://github.com/alexays/waybar) |
| Launcher | [Wofi](https://hg.sr.ht/~scoopta/wofi) |

## Documentation

In the [docs folder](https://github.com/luantorv/nixconf/tree/main/docs) you can find detailed documentation on implementing [secrets](https://github.com/luantorv/nixconf/blob/main/docs/SECRETS.md), [keybinds](https://github.com/luantorv/nixconf/blob/main/docs/KEYBINDS.md), [android integration](https://github.com/luantorv/nixconf/blob/main/docs/ANDROID-INTEGRATION.md) and [how to prove or test](https://github.com/luantorv/nixconf/blob/main/docs/INSTALLATION%20and%20UPDATING.md) this configuration.

## Credits

In [CREDITS.md](CREDITS.md) you can find the sources for the images (except for the [screenshoots](https://github.com/luantorv/nixconf/tree/main/assets/screenshoots), obviously) available in this repository.

## Disclaimer

This project is primarily designed for personal use.

Feel free to adapt it, fork it, or break it.

## Author:

- [GitHub](https://github.com/luantorv/)
- [Discord](https://discord.com/users/711613864386625618)
