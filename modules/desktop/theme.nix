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

    environment.sessionVariables = {
      GTK_THEME = "Adwaita:dark";
      ICON_THEME = "Colloid-Nord-Dark";
      XCURSOR_THEME = "Bocchi";
      XCURSOR_SIZE = 36;
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

    programs.dconf.profiles.user.databases =
      let
        gvariant = lib.gvariant;
      in
      [
        {
          lockAll = true;
          settings = {
            "org/gnome/desktop/input-sources" = {
              xkb-options = gvariant.mkArray [ "caps:swapescape" ];
            };

            "org/gnome/desktop/interface" = {
              accent-color = "blue";
              clock-format = "24h";
              clock-show-seconds = gvariant.mkBoolean true;
              color-scheme = "prefer-dark";
              cursor-size = gvariant.mkInt32 36;
              cursor-theme = "Bocchi";
              document-font-name = "Sans 11";
              font-name = "Sans 11";
              gtk-theme = "Adwaita";
              icon-theme = "Colloid-Nord-Dark";
              monospace-font-name = "Monospace 11";
              toolbar-icons-size = "small";
              toolbar-style = "icons";
            };

            "org/gnome/desktop/wm/preferences" = {
              button-layout = "appmenu:";
              titlebar-font = "Sans Bold 11";
            };

            "org/gnome/nautilus/list-view" = {
              use-tree-view = gvariant.mkBoolean true;
            };

            "org/gnome/nautilus/preferences" = {
              click-policy = "single";
              date-time-format = "detailed";
              default-folder-viewer = "list-view";
              show-delete-permanently = gvariant.mkBoolean false;
            };

            "org/gnome/papers" = {
              night-mode = gvariant.mkBoolean false;
            };

            "org/gtk/gtk4/settings/file-chooser" = {
              show-hidden = gvariant.mkBoolean true;
              sort-directories-first = gvariant.mkBoolean false;
            };
          };
        }
      ];
  };
}
