{
  config,
  pkgs,
  inputs,
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
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    hjem.users.${userName}.xdg.config.files = {
      "noctalia/colors.json" = {
        source = "${external}/noctalia/colors.json";
        permissions = "440";
      };
      "noctalia/plugins.json" = {
        source = "${external}/noctalia/plugins.json";
        permissions = "440";
      };
      "noctalia/settings.json" = {
        source = "${external}/noctalia/settings.json";
        permissions = "440";
      };
      "noctalia/plugins/privacy-indicator/settings.json" = {
        source = "${external}/noctalia/plugins/privacy-indicator/settings.json";
        permissions = "440";
      };
      "noctalia/plugins/screen-recorder/settings.json" = {
        source = "${external}/noctalia/plugins/screen-recorder/settings.json";
        permissions = "440";
      };
    };

    environment.sessionVariables = {
      QS_ICON_THEME = "Colloid-Nord-Dark";
    };
  };
}
