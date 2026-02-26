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
    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "kvantum";
    };

    hjem.users.${userName}.xdg.config.files = {
      "Kvantum/Nordic".source = "${pkgs.nordic}/share/Kvantum/Nordic";
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=Nordic
      '';
    };
  };
}
