{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    parted
    xfsprogs

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
