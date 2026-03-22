{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.mymod.dev.direnv;
in
{
  options.mymod = {
    dev.direnv = {
      enable = lib.mkEnableOption "Direnv" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.direnv.enable = true;

    services.angrr = {
      enable = true;
      period = "14d";
    };
  };
}
