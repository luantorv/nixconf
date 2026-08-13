# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, ... }:

{
  xdg.configFile."hyfetch.json" = {
    executable = true;
    text = ''
      {
        "preset": "transgender",
        "mode": "rgb",
        "auto_detect_light_dark": true,
        "light_dark": "dark",
        "lightness": 0.65,
        "color_align": {
          "mode": "horizontal"
        },
        "backend": "fastfetch",
        "args": null,
        "distro": null,
        "pride_month_disable": false,
        "custom_ascii_path": null,
        "custom_presets": null,
        "palette_glyph": null,
        "palette_type": null
      }
    '';
  };
}