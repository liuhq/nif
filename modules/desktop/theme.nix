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
    environment.systemPackages = with pkgs; [
      colloid-icon-theme
    ];

    hjem.users.${userName} = {
      xdg.data.files = {
        "icons/default".source = pkgs.bocchi-dyn-cursor;
        "icons/Bocchi".source = pkgs.bocchi-dyn-cursor;
      };
    };

    programs.dconf.profiles.user.databases = [
      {
        lockAll = true;
        settings = {
          "org/gnome/desktop/input-sources" = {
            xkb-options = [ "caps:swapescape" ];
          };

          "org/gnome/desktop/interface" = {
            accent-color = "blue";
            clock-format = "24h";
            clock-show-seconds = true;
            color-scheme = "prefer-dark";
            cursor-size = 36;
            cursor-theme = "Bocchi";
            document-font-name = "Sans 11";
            font-name = "Sans 11";
            gtk-theme = "Adwaita";
            icon-theme = "Colloid-Dark";
            monospace-font-name = "Monospace 11";
            toolbar-icons-size = "small";
            toolbar-style = "icons";
          };

          "org/gnome/desktop/wm/preferences" = {
            button-layout = "appmenu:";
            titlebar-font = "Sans Bold 11";
          };

          "org/gnome/nautilus/list-view" = {
            use-tree-view = true;
          };

          "org/gnome/nautilus/preferences" = {
            click-policy = "single";
            date-time-format = "detailed";
            default-folder-viewer = "list-view";
            show-delete-permanently = false;
          };

          "org/gnome/papers" = {
            night-mode = false;
          };

          "org/gtk/gtk4/settings/file-chooser" = {
            show-hidden = true;
            sort-directories-first = false;
          };
        };
      }
    ];
  };
}
