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
    programs.obs-studio = {
      enable = true;
      plugins = [ ];
    };
  };
}
