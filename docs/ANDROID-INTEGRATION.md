# Android Integration

Packages and options for Android device integration on NixOS.

## Configuration

```nix
programs.adb.enable = true;
services.gvfs.enable = true;

users.users."${globalVars.username}".extraGroups = [ "adbusers" ];

environment.systemPackages = with pkgs; [
  libmtp
  mtpfs
  scrcpy
];
```

## Features

### File Transfer (USB)
Uses MTP via `libmtp` and `mtpfs`. `gvfs` must be enabled as a service for automounting to work in standalone window managers.

### Screen Mirror / Control
`scrcpy` streams the Android display into a window and allows full keyboard and mouse control over the device. Requires USB connection with USB debugging enabled on the device, or a network connection via ADB over TCP/IP.

`programs.adb.enable` handles `android-tools`, udev rules, and the `adbusers` group automatically.
