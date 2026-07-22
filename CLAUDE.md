# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

**Rebuild and switch (laptop):**
```bash
sudo nixos-rebuild switch --flake .#laptop
```

**Rebuild and switch (server):**
```bash
sudo nixos-rebuild switch --flake .#server
```

**Update flake inputs then rebuild:**
```bash
nix flake update
sudo nixos-rebuild switch --flake .#laptop
```

**Edit secrets:**
```bash
nix run nixpkgs#sops -- secrets/secrets.yaml
```

**Test a build without switching:**
```bash
sudo nixos-rebuild build --flake .#laptop
```

## Architecture

### Entry Point and Global Variables

`flake.nix` is the single entry point. It defines `globalVars` (username, homeDirectory, system, stateVersion, wallpaperDir paths) which are threaded as `specialArgs` into every NixOS and Home Manager module. Both `nixpkgs-old` (25.11) and `nixpkgs-new` (unstable) are instantiated alongside the primary `nixpkgs` (26.05) and made available as `pkgs-old` / `pkgs-new` for packages that need a different nixpkgs version.

### Layer Structure

```
flake.nix
  └── hosts/<machine>/default.nix   # hardware + selects a profile
        └── profiles/<profile>.nix  # assembles NixOS + Home Manager module sets
              ├── modules/nixos/     # system-level config
              └── modules/home/      # user-level config (via home-manager)
```

**hosts/** — machine-specific concerns only: hardware config, boot loader, hostname, Docker. The host file selects exactly one profile.

**profiles/** — three options:
- `minimal.nix` — CLI/TUI only
- `river.nix` — River (Wayland WM) desktop
- `niri.nix` — Niri (Wayland WM) desktop, uses the `noctalia` flake input for its shell/bar

**modules/nixos/** — NixOS system modules. `core/` (base, networking, nix settings) is always imported by every profile. Other files (packages, services, security, users, variables) are imported per-profile.

**modules/home/** — Home Manager modules organized by concern: `desktop/`, `editors/` (Neovim with Lua configs in `editors/lua/`), `files/`, `niri/`, `river/`, `shell/`, `terminal/`, `theme/`, and top-level files for cliphist, sops, and variables. Package lists live in `modules/home/packages/` with one file per profile tier.

### Secrets

Secrets use `sops-nix` with age encryption derived from the user's SSH ed25519 key. `secrets/secrets.yaml` is encrypted and safe to commit. `.sops.yaml` at the repo root declares which age keys can decrypt it. Secrets are declared in `modules/home/sops.nix` and decrypted at activation time. See `docs/SECRETS.md` for the full bootstrap procedure for new machines.

### Adding a New Machine

1. Copy `hardware-configuration.nix` from `nixos-generate-config` output into `hosts/<newmachine>/`.
2. Create `hosts/<newmachine>/default.nix` importing hardware files and a profile.
3. Add a `nixosConfigurations.<newmachine>` entry in `flake.nix` with the appropriate `specialArgs`.
4. Bootstrap SOPS for the new machine's SSH key (see `docs/SECRETS.md`).
