# Installation

## Prerequisites

All three scenarios assume you have booted into a NixOS live environment or an existing NixOS system. The configuration uses flakes, so nix with flakes support is required throughout.

If your current nix version does not have flakes enabled, add this flag to every nix command used below:

```
--extra-experimental-features 'nix-command flakes'
```

Or enable it permanently in your current session:

```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
```

### 1. Fresh NixOS install (post-installer)

This assumes you have just finished partitioning and mounting your drives and have generated a `hardware-configuration.nix` via `nixos-generate-config`.

- Clone the repository

```bash
git clone https://github.com/luantorv/nixconf.git /mnt/etc/nixos
cd /mnt/etc/nixos
```

- Copy your hardware configuration

```bash
cp /etc/nixos/hardware-configuration.nix hosts/laptop/hardware-configuration.nix
```

- Adjust global variables

Edit `flake.nix` and set your username and home directory:

```nix
globalVars = {
  username              = "youruser";
  homeDirectory         = "/home/youruser";
  system                = "x86_64-linux";
  wallpaperDir          = "/home/youruser/Images/Wallpapers"; # Absolute path
  wallpaperRelativePath = "Images/Wallpapers"; # Relavite to the home
};
```

- Install

```bash
nixos-install --flake /mnt/etc/nixos#laptop
```

- Reboot

```bash
reboot
```

After rebooting, the repository will be at `/etc/nixos`. Future rebuilds are done from there.

### 2. Applying to an existing NixOS system

This assumes NixOS is already running and you want to replace your current configuration with this one.

- Clone the repository

```bash
git clone https://github.com/luantorv/nixconf.git ~/nixconf
cd ~/nixconf
```

- Copy your hardware configuration

```bash
cp /etc/nixos/hardware-configuration.nix hosts/laptop/hardware-configuration.nix
```

- Adjust global variables

Edit `flake.nix` and set your username and home directory:

```nix
globalVars = {
  username              = "youruser";
  homeDirectory         = "/home/youruser";
  system                = "x86_64-linux";
  wallpaperDir          = "/home/youruser/Images/Wallpapers"; # Absolute path
  wallpaperRelativePath = "Images/Wallpapers"; # Relavite to the home
};
```

- Apply

```bash
sudo nixos-rebuild switch --flake .#laptop
```

- (Optional) Move to `/etc/nixos`

If you want the configuration to live in the conventional location:

```bash
sudo mv ~/nixconf /etc/nixos
```

Future rebuilds:

```bash
cd /etc/nixos && sudo nixos-rebuild switch --flake .#laptop
```

### 3. Home Manager only (without managing the system)

This scenario applies if you are running NixOS (or another Linux distribution) and only want to manage your user environment, without this flake touching system-level configuration.

>[!NOTE] 
> This configuration uses Home Manager as a NixOS module. Running it standalone requires minor adjustments. See the note at the end of this section.

- Install Home Manager (standalone)

```bash
nix run home-manager/master -- init --switch
```

- Clone the repository

```bash
git clone https://github.com/luantorv/nixconf.git ~/nixconf
cd ~/nixconf
```

- Adjust global variables

Edit `flake.nix` and set your username and home directory.

- Apply

```bash
home-manager switch --flake .#youruser
```

> This requires adding a homeConfigurations output to `flake.nix` that points directly to the desired profile's home modules, since the standalone mode does not go through `nixosModules.home-manager`. The system-level modules (`modules/nixos/`) will have no effect in this scenario.

# Updating

- Pull the latest changes and rebuild:

```bash
git pull
sudo nixos-rebuild switch --flake .#laptop
```

To update flake inputs (nixpkgs, home-manager, etc.) before rebuilding:

```bash
nix flake update
sudo nixos-rebuild switch --flake .#laptop
```