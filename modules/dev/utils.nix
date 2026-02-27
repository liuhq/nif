{ config, pkgs, ... }:
{
  # old home
  environment.systemPackages = with pkgs; [
    clang
    cmake
    dprint
    gdb
    just
    meson
    prettier
    steel
  ];
}
