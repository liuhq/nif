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
      "noctalia/colors.json".source = "${external}/noctalia/colors.json";
      "noctalia/plugins.json".source = "${external}/noctalia/plugins.json";
      "noctalia/settings.json".source = "${external}/noctalia/settings.json";
    };

    environment.sessionVariables = {
      QS_ICON_THEME = "Colloid-Dark";
    };
  };
}
