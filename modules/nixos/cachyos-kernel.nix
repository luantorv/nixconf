# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

# Kernel CachyOS (xddxdd/nix-cachyos-kernel).
#
# Expone el overlay `pinned`, que fija la revisión de nixpkgs usada por el
# flake para garantizar aciertos en el cache binario (evita recompilar el
# kernel localmente). Los paquetes quedan disponibles bajo
# `pkgs.cachyosKernels.*`.
#
# Cada host elige su variante con `boot.kernelPackages` en su propio boot.nix.

{ nix-cachyos-kernel, ... }:

{
  nixpkgs.overlays = [ nix-cachyos-kernel.overlays.pinned ];

  # Cache binario de Lantian. Se usa `extra-*` para añadirlo sin sobrescribir
  # el sustituto por defecto (cache.nixos.org).
  nix.settings = {
    extra-substituters = [ "https://attic.xuyh0120.win/lantian" ];
    extra-trusted-public-keys = [
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };
}
