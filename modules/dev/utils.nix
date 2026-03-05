{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    just
    dprint
  ];
}
