{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.mymod.desktop;
in
{
  config = lib.mkIf cfg.enable {
    hardware.opentabletdriver = {
      enable = true;
    };

    hardware.uinput.enable = true;
    boot.kernelModules = [ "uinput" ];
  };
}
