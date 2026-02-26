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
  options.mymod.desktop = {
    enable = lib.mkEnableOption "desktop";
    systemdTargets = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "graphical-session.target" ];
      example = [ "niri-session.target" ];
      description = "The systemd targets that will automatically start the user services.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
