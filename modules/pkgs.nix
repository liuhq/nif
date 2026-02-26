{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    parted
    btrfs-progs
    compsize

    iwd
    dig

    zstd
    zip
    unzip
    p7zip

    age
    gopass

    fd
    jq
    ripgrep
    strace

    libnotify
    trash-cli

    aseprite
    eyedropper
    game-devices-udev-rules
    gnome-calculator
    gnome-characters
    helvum
    minder
    papers
  ];
}
