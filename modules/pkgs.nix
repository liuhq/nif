{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    parted
    xfsprogs

    iwd
    dig
    xh

    zstd
    zip
    unzip
    p7zip

    age
    gopass

    procs
    duf
    dust
    fd
    jq
    ripgrep
    strace

    wl-clipboard
    trash-cli
  ];
}
