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

      colloid-icon-theme
    ];

    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "kvantum";
    };

    hjem.users.${userName} = {
      xdg.config.files = {
        "gtk-4.0".source = "${external}/gtk/gtk-4.0";
        "gtk-3.0".source = "${external}/gtk/gtk-3.0";

        "Kvantum/Nordic".source = "${pkgs.nordic}/share/Kvantum/Nordic";
        "Kvantum/kvantum.kvconfig".text = ''
          [General]
          theme=Nordic
        '';
      };

      xdg.data.files = {
        # "icons/default".source = "${pkgs.bocchi-dyn-cursor}/share/icons/Bocchi";
        # "icons/Bocchi".source = "${pkgs.bocchi-dyn-cursor}/share/icons/Bocchi";
        "themes/wallpaper".source = pkgs.my-wallpaper;
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
