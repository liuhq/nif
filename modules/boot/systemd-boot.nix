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
    boot.systemd-boot.enable = lib.mkEnableOption "systemd-boot" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    boot.kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.udev.log_level=3"
      "systemd.show_status=auto"
      "vt.global_cursor_default=0"
      "fbcon=nodefer"
      "preempt=full"
    ];
    boot.plymouth.enable = true;

    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };

    boot.loader.efi.canTouchEfiVariables = true;
  };
}
