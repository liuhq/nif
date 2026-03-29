{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.mymod.boot.systemd-boot;
in
{
  options.mymod = {
    boot.systemd-boot.enable = lib.mkEnableOption "systemd-boot";
  };

  config = lib.mkIf cfg.enable {
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };

    boot.loader.efi.canTouchEfiVariables = true;
  };
}
