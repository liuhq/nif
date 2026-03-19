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
    services.tuned.enable = true;
    services.tuned.ppdSettings.main.default = "performance";

    services.upower.enable = true;
  };
}
