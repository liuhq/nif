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
      # For show-keys plugin
      pkgs.evtest
      # For screen-recorder plugin
      pkgs.gpu-screen-recorder
    ];

    # For show-keys plugin
    users.users.${userName}.extraGroups = [ "input" ];

    hjem.users.${userName}.xdg.config.files = {
      "noctalia/settings.json" = {
        source = "${external}/noctalia/settings.json";
        type = "copy";
        permissions = "440";
      };
      "noctalia/colorschemes/CatppuccinMacchiatoLavender/CatppuccinMacchiatoLavender.json" = {
        source = "${external}/noctalia/colorschemes/CatppuccinMacchiatoLavender/CatppuccinMacchiatoLavender.json";
        type = "copy";
        permissions = "440";
      };
      "noctalia/plugins.json" = {
        source = "${external}/noctalia/plugins.json";
        type = "copy";
        permissions = "440";
      };
      "noctalia/plugins/privacy-indicator/settings.json" = {
        source = "${external}/noctalia/plugins/privacy-indicator/settings.json";
        type = "copy";
        permissions = "440";
      };
      "noctalia/plugins/screen-recorder/settings.json" = {
        source = "${external}/noctalia/plugins/screen-recorder/settings.json";
        type = "copy";
        permissions = "440";
      };
    };

    environment.variables = {
      QS_ICON_THEME = "Colloid-Nord-Dark";
    };
  };
}
