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
    services.flatpak.enable = true;

    services.flatpak.packages = [
      "com.valvesoftware.Steam"
      "com.vysp3r.ProtonPlus"
    ];

    services.flatpak.overrides = {
      global = {
        Context = {
          sockets = [ "wayland" ];
          filesystems = [
            "~/.local/share/fonts"
            "~/.local/share/themes"
            "~/.local/share/icons"
            "~/.config/fontconfig"
            "/run/current-system/sw/bin:ro" # Expose NixOS managed software
          ];
        };

        Environment = {
          ICON_THEME = "Colloid-Dark";
          XCURSOR_PATH = "~/.local/share/icons:/run/host/user-share/icons:/run/host/share/icons";
          XCURSOR_THEME = "Bocchi";
          XCURSOR_SIZE = 36;

          GTK_THEME = "Adwaita:dark";
        };
      };

      "com.valvesoftware.Steam" = {
        Context = {
          sockets = [
            "system-bus"
            "session-bus"
          ];
          devices = [
            "shm"
            "kvm"
            "input"
            "dri"
          ];
        };
        Environment = {
          GTK_IM_MODULE = "fcitx5";
          LANG = "zh_CN.UTF-8";
          LC_ALL = "zh_CN.UTF-8";
          DISPLAY = ":0";
        };
      };
    };
  };
}
