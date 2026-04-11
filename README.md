# NixConf

My personal [NixOS](https://nixos.org) configuration featuring the [River](https://github.com/riverwm/river) window manager on Wayland using [Home Manager](https://github.com/nix-community/home-manager).


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
│   │   ├── packages/
│   │   ├── shell/
│   │   ├── terminal/
│   │   └── theme/
│   └── nixos/         # NixOS modules
│       ├── boot/
│       └── core/
├── profiles/          # Module bundles per use case
│   ├── desktop.nix
│   └── minimal.nix
├── secrets/           # Secrets handled by SOPS
└── README.md
```

## Screenshoots

<div align="center">
  <img src="assets/screenshoots/foot-fastfetch.png" alt="Fastfetch" width="45%">
  <img src="assets/screenshoots/waybar.png" alt="Waybar" width="45%">
  <img src="assets/screenshoots/wofi.png" alt="Wofi launcher" width="45%">
  <img src="assets/screenshoots/wofi-energy_menu.png" alt="Wofi power menu" width="45%">
  <img src="assets/screenshoots/nvim.png" alt="Vim" width="45%">
  <img src="assets/screenshoots/btop.png" alt="Htop" width="45%">
</div>

## System Information
| Components |  |
|---|---|
| OS | [NixOS 25.11 (Xantusia)](https://nixos.org) |
| WM | [River (wayland)](https://codeberg.org/river/river-classic) |
| Terminal | [Foot](https://codeberg.org/dnkl/foot/) |
| Shell | [Bash](https://www.gnu.org/software/bash/) |
| Editor | [Vim](https://www.vim.org/) - [NeoVim](https://neovim.io/) - [VSCodium](https://vscodium.com/) |
| File Manager | [yazi](https://github.com/sxyazi/yazi) - [Thunar](https://gitlab.xfce.org/xfce/thunar) |
| Status Bar | [waybar](https://github.com/alexays/waybar) |
| Launcher | [Wofi](https://hg.sr.ht/~scoopta/wofi) |
| Browser | [Brave](https://brave.com/) |

## Documentation

In the [docs](https://github.com/luantorv/nixconf/tree/main/docs) folder you can find detailed documentation on implementing [secrets](https://github.com/luantorv/nixconf/blob/main/docs/SECRETS.md), [keybinds](https://github.com/luantorv/nixconf/blob/main/docs/KEYBINDS.md), and [how to prove or test](https://github.com/luantorv/nixconf/blob/main/docs/INSTALLATION%20and%20UPDATING.md) this configuration.

## Credits

In [CREDITS.md](CREDITS.md) you can find the sources for the images (except for the screenshoots, obviously) available in this repository.

## Disclaimer

This project is primarily designed for personal use.
Feel free to adapt it, fork it, or break it.

## Author:

- [GitHub](https://github.com/luantorv/)
- [Discord](https://discord.com/users/711613864386625618)
