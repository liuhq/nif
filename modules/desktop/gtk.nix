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
    environment.systemPackages = with pkgs; [
      gtk4
      gtk3
    ];

    hjem.users.${userName}.xdg.config.files = {
      "gtk-3.0".source = "${external}/gtk/gtk-3.0";
      "gtk-4.0".source = "${external}/gtk/gtk-4.0";
    };
  };
}
