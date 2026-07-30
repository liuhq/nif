{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.desktop;
in
{
  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;

    # services.flatpak.overrides = {
    #   global = {
    #     Context = {
    #       sockets = [ "wayland" ];
    #       filesystems = [
    #         "~/.local/share/fonts"
    #         "~/.local/share/themes"
    #         "~/.local/share/icons"
    #         "~/.config/fontconfig"
    #         "/run/current-system/sw/bin:ro" # Expose NixOS managed software
    #         "/nix/store:ro" # https://wiki.nixos.org/wiki/Cursor_Themes#Giving_flatpaks_permission_to_/nix/store
    #       ];
    #     };
    #
    #     Environment = {
    #       ICON_THEME = "Colloid-Nord-Dark";
    #       XCURSOR_PATH = "~/.local/share/icons:/usr/share/icons:/run/host/user-share/icons:/run/host/share/icons";
    #       XCURSOR_THEME = "Bocchi";
    #       XCURSOR_SIZE = "36";
    #
    #       GTK_THEME = "Colloid-Dark-Nord";
    #     };
    #   };
    # };
  };
}
