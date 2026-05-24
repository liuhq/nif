{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  cfg = config.mymod.desktop;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.which-key-wayland.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
