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
  toIni = lib.generators.toINI {
    mkKeyValue =
      key: value:
      let
        value' = if lib.isBool value then lib.boolToString value else toString value;
      in
      "${lib.escape [ "=" ] key}=${value'}";
  };
  fontSettings =
    let
      size = "12";
    in
    {
      inherit size;
      sans = "Sans ${size}";
      monospace = "Monospace ${size}";
    };
  mkGtkSettings =
    gtkVersion:
    let
      common = {
        gtk-font-name = fontSettings.sans;
        gtk-theme-name = "Colloid-Dark-Nord";
        gtk-icon-theme-name = "Colloid-Nord-Dark";
        gtk-cursor-theme-name = "Bocchi";
        gtk-cursor-theme-size = 36;
        gtk-application-prefer-dark-theme = true;
      };
      gtk4Only = lib.optionalAttrs (gtkVersion == 4) {
        gtk-interface-color-scheme = 2;
      };
    in
    common // gtk4Only;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gtk4
      gtk3
      gtk2

      colloid-gtk-theme
      colloid-icon-theme
    ];

    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "kvantum";
    };

    environment.sessionVariables = {
      GTK_THEME = "Colloid-Dark-Nord";
      ICON_THEME = "Colloid-Nord-Dark";
      XCURSOR_THEME = "Bocchi";
      XCURSOR_SIZE = 36;
    };

    hjem.users.${userName} = {
      xdg.config.files = {
        "assets".source = "${pkgs.colloid-gtk-theme}/share/themes/Colloid-Dark-Nord/gtk-4.0/assets";

        "gtk-4.0".source = pkgs.symlinkJoin {
          name = "gtk-4.0-config";
          paths = [
            (pkgs.writeTextFile {
              name = "gtk-4.0-settings";
              text = (
                toIni {
                  Settings = mkGtkSettings 4;
                }
              );
              destination = "/settings.ini";
            })
            "${pkgs.colloid-gtk-theme}/share/themes/Colloid-Dark-Nord/gtk-4.0"
          ];
        };

        "gtk-3.0".source = pkgs.symlinkJoin {
          name = "gtk-3.0-config";
          paths = [
            (pkgs.writeTextFile {
              name = "gtk-3.0-settings";
              text = (
                toIni {
                  Settings = mkGtkSettings 3;
                }
              );
              destination = "/settings.ini";
            })
            "${pkgs.colloid-gtk-theme}/share/themes/Colloid-Dark-Nord/gtk-3.0"
          ];
        };

        "gtk-2.0".source = "${pkgs.colloid-gtk-theme}/share/themes/Colloid-Dark-Nord/gtk-2.0";

        "Kvantum/catppuccin-macchiato-lavender".source =
          "${pkgs.catppuccin-kvantum}/share/Kvantum/catppuccin-macchiato-lavender";
        "Kvantum/kvantum.kvconfig".text = ''
          [General]
          theme=catppuccin-macchiato-lavender
        '';
      };

      xdg.data.files = {
        "icons/default".source = "${pkgs.bocchi-dyn-cursor}/share/icons/Bocchi";
        "icons/Bocchi".source = "${pkgs.bocchi-dyn-cursor}/share/icons/Bocchi";
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
          settings =
            let
              gtkSettings = mkGtkSettings 3;
            in
            {
              "org/gnome/desktop/input-sources" = {
                xkb-options = gvariant.mkArray [ "caps:swapescape" ];
              };

              "org/gnome/desktop/interface" = {
                accent-color = "teal";
                clock-format = "24h";
                clock-show-seconds = gvariant.mkBoolean true;
                color-scheme = "prefer-dark";
                cursor-size = gvariant.mkInt32 gtkSettings.gtk-cursor-theme-size;
                cursor-theme = gtkSettings.gtk-cursor-theme-name;
                document-font-name = gtkSettings.gtk-font-name;
                font-name = gtkSettings.gtk-font-name;
                gtk-theme = gtkSettings.gtk-theme-name;
                icon-theme = gtkSettings.gtk-icon-theme-name;
                monospace-font-name = fontSettings.monospace;
                toolbar-style = "icons";
              };

              "org/gnome/desktop/wm/preferences" = {
                theme = gtkSettings.gtk-theme-name;
                button-layout = "appmenu:";
                titlebar-font = "Sans Bold ${fontSettings.size}";
              };

              "org/gnome/nautilus/preferences" = {
                date-time-format = "detailed";
                default-folder-viewer = "list-view";
                show-delete-permanently = gvariant.mkBoolean false;
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
