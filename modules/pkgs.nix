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

    trash-cli
  ];
}
