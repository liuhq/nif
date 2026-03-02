{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.desktop;
  inherit (myvar) userName;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.colloid-icon-theme
    ];

    hjem.users.${userName} = {
      xdg.data.files = {
        "icons/default".source = pkgs.bocchi-dyn-cursor;
        "icons/Bocchi".source = pkgs.bocchi-dyn-cursor;
      };
    };
  };
}
