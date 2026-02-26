{
  config,
  pkgs,
  lib,
  myvar,
  paths,
  ...
}:
let
  cfg = config.mymod.desktop;
  inherit (myvar) userName;
  inherit (paths) external;
in
{
  config = lib.mkIf cfg.enable {
    services.noctalia-shell.enable = true;

    hjem.users.${userName}.xdg.config.files = {
      "noctalia".source = "${external}/noctalia";
    };

    environment.variables = {
      QS_ICON_THEME = "Colloid-Dark";
    };
  };
}
