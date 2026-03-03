{ config, pkgs, ... }:
{
  # old home
  environment.systemPackages = with pkgs; [
    just

    dprint

    steel
  ];
}
