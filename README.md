# NixConf

My personal [NixOS](https://nixos.org) configuration featuring the [River](https://github.com/riverwm/river) window manager on Wayland using [Home Manager](https://github.com/nix-community/home-manager).

## Screenshoots

<div align="center">
  <img src="assets/screenshoots/foot-fastfetch.png" alt="Fastfetch" width="45%">
  <img src="assets/screenshoots/waybar.png" alt="Waybar" width="45%">
  <img src="assets/screenshoots/wofi.png" alt="Wofi launcher" width="45%">
  <img src="assets/screenshoots/wofi-energy_menu.png" alt="Wofi power menu" width="45%">
  <img src="assets/screenshoots/nvim.png" alt="Vim" width="45%">
  <img src="assets/screenshoots/htop.png" alt="Htop" width="45%">
</div>

## System Information

- OS: NixOS 25.11 (Xantusia)
- Window Manager: River (Wayland compositor)
- Terminal: foot
- Shell: bash
- Editor: vim - nvim - vscodium
- File Manager: yazi - thunar
- Status Bar: waybar
- Launcher: wofi
- GTK Theme: Adwaita-dark
- Icons: Adwaita
- Font: JetBrains Mono (12pt)
- Cursor: Adwaita (24px)

## Installation

### Prerequisites

- A working NixOS installation
- Git installed
- Home Manager instaled

>[!TIP]
> If you don't have Home Manager installed yet:
>
> ```sh
> bashnix-channel --add https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz home-manager
> nix-channel --update
> nix-shell '<home-manager>' -A install
> ```

### Clone the Repository

- To clone without screenshots (recommended):

```sh
git clone --filter=blob:none --no-checkout https://github.com/luantorv/nixconf.git
cd nixconf
git sparse-checkout init --cone
git sparse-checkout set nixos home-manager assets/wallpapers
git checkout
```

- Or clone everything:

```sh
git clone https://github.com/luantorv/nixconf.git
cd nixconf
```

### Apply Configuration

- NixOS system configuration:

```sh
sudo cp -r nixos/* /etc/nixos/
sudo nixos-rebuild switch
```

- Home Manager configuration:

```sh
cp -r home-manager/* ~/.config/home-manager/
home-manager switch
```

- Wallpapers (optional):

```sh
mkdir -p ~/Images/Wallpapers
cp -r assets/wallpapers/* ~/Images/Wallpapers/
```

## Configuration Layout

### NixOS Configuration (`/etc/nixos/`)

The NixOS configuration is split into modules for better organization:

- `boot.nix`: Bootloader and kernel configuration
- `disk.nix`: Auto mounting partition
- `networking.nix`: Network settings
- `packages.nix`: System-wide packages
- `security.nix`: Security policies and settings
- `services.nix`: System services configuration
- `users.nix`: User account definitions

### Home Manager Configuration (`~/.config/home-manager/`)

User-specific configuration managed through Home Manager:

- In `~/.config/home-manager/modules/`
    - `bash.nix`: Bash shell configuration
    - `cliphist.nix`: Clipboard history manager
    - `colors.nix`: Color Pallete 
    - `foot.nix`: Terminal emulator settings
    - `gtk.nix`: GTK theme and appearance
    - `home-manager.nix`: Home Manager Basic Config
    - `kanshi.nix`: Display output management
    - `nvim.nix`: Neovim minimal config
    - `packages.nix`: User packages
    - `river.nix`: River window manager configuration
    - `swappy.nix`: Some screenshoot config
    - `swaylock.nix`: Screen locker settings
    - `variables.nix`: Environment variables
    - `vim.nix`: Vim editor configuration
    - `waybar.nix`: Status bar configuration
    - `wofi.nix`: Application launcher settings
    - `yazi.nix`: Config for file management

- In `~/.config/home-manager/scripts/`
    - `wallpaper_cycle.sh`: for presentation of wallpapers

## Credits

All wallpapers available in [wallpapers](https://github.com/luantorv/nixconf/tree/main/assets/wallpapers/) were extracted from [wallhaven](https://wallhaven.cc).

The wallpapers in this repository are the property of their respective authors. I do not claim ownership of any artwork shared here.

if you recognize any of these works and know the original artist, or if you are the creator of an image and would like it to be specifically credited (or removed), please reach out directly via any of my [contact methods](#author)

The image for [swaylock-effects](https://github.com/jirutka/swaylock-effects) were extracted from [nixos-artwork GitHub repository](https://github.com/NixOS/nixos-artwork/blob/master/wallpapers/nix-wallpaper-dracula.png).

## Disclaimer

This project is primarily designed for personal use.
Feel free to adapt it, fork it, or break it.

## Author:

Reis Viera, Luis
- GitHub: [@luantorv](https://github.com/luantorv/)
- Discord: [@luis_](https://discord.com/users/711613864386625618)
