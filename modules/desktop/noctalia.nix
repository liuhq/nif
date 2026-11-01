{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.desktop;
  hjemCfg = config.hjem.users.${userName};
  inherit (myvar) userName;
in
{
  config = lib.mkIf cfg.enable {
    hjem.users.${userName} = {
      programs.noctalia = {
        enable = true;
        systemd = {
          enable = true;
          target = lib.head cfg.systemdTargets;
        };
        settings = {
          theme = {
            builtin = "Nord";
            sync_color_scheme = false;
            templates = {
              enable_builtin_templates = false;
              enable_community_templates = false;
            };
          };
          wallpaper = {
            directory = "${hjemCfg.xdg.data.directory}/themes/wallpaper";
            fill_mode = "crop";

            automation = {
              enabled = true;
              interval_seconds = 28800;
            };
          };
          desktop_widgets.enabled = false;

          shell = {
            lang = "en";
            time_format = "{:%H:%M:%S}";
            avatar_path = "${hjemCfg.xdg.data.directory}/themes/avatar/avatar.png";

            corner_radius_scale = 0.5;
            button_borders = false;
            card_borders = false;
            input_borders = false;
            popup_borders = false;

            readline_shortcuts = true;
            show_close_buttons = false;

            launch_apps_as_systemd_services = true;
            polkit_agent = true;
            screen_time_enabled = true;

            launcher = {
              category_icons_only = true;
              show_session_button = false;
              show_settings_button = false;

              providers = {
                calculator = {
                  global = false;
                  prefix = "=";
                };
                session.prefix = "/";
              };
            };
            panel = {
              session_placement = "floating";
              session_position = "center";

              borders = false;
            };
            screenshot = {
              directory = "${hjemCfg.environment.sessionVariables.XDG_PICTURES_DIR}/Screenshots";

              confirm_region = true;
              remember_last_region = true;
            };
            session.actions = [
              {
                action = "lock";
                countdown_seconds = 0.0;
                enabled = true;
                shortcut = "l";
                variant = "default";
              }
              {
                action = "logout";
                countdown_seconds = 5.0;
                enabled = true;
                shortcut = "o";
                variant = "default";
              }
              {
                action = "lock_and_suspend";
                countdown_seconds = 10.0;
                enabled = true;
                shortcut = "s";
                variant = "default";
              }
              {
                action = "reboot";
                countdown_seconds = 10.0;
                enabled = true;
                shortcut = "r";
                variant = "default";
              }
              {
                action = "shutdown";
                countdown_seconds = 10.0;
                enabled = true;
                shortcut = "d";
                variant = "destructive";
              }
            ];
          };
          keybinds = {
            up = [
              "Up"
              "Ctrl+p"
            ];
            down = [
              "Down"
              "Ctrl+n"
            ];
            left = [
              "Left"
              "Ctrl+b"
            ];
            right = [
              "Right"
              "Ctrl+f"
            ];

            validate = [ "Return" ];
          };

          bar.default = {
            start = [
              "launcher"
              "workspaces"
              "tray"
              "active_window"
            ];
            center = [
              "privacy"
              "clock"
              "media"
            ];
            end = [
              "network_rx"
              "network_tx"
              "spacer_0"
              "cpu"
              "ram"
              "spacer_0"
              "volume"
              "network"
              "bluetooth"
              "brightness"
              "notifications"
              "control-center"
            ];

            thickness = 36;
            margin_edge = 4;
            margin_ends = 4;
            widget_spacing = 14;

            radius = 4;

            reserve_space = false;
            smart_auto_hide = true;
          };
          widget = {
            launcher = {
              glyph = "rocket";
              icon_color = "primary";
            };
            workspaces = {
              active_pill_size = 2.0;
              pill_scale = 0.75;
              show_labels = false;
            };
            tray = {
              drawer = true;
              drawer_columns = 5;
              pinned = [ "Fcitx" ];
            };
            active_window = {
              display = "text_only";
              title_scroll = "on_hover";
            };

            privacy.hide_inactive = true;
            clock = {
              format = "{:%H:%M:%S  %a, %b %d}";
              tooltip_format = "{:%Y-%m-%d}";
            };
            media = {
              color = "primary";
              hide_when_no_media = true;
              title_scroll = "always";
            };

            network_rx.interactive = false;
            network_tx.interactive = false;
            spacer_0 = {
              length = 24;
              type = "spacer";
            };
            ram.interactive = false;
            network.show_label = false;
            notifications.hide_when_no_unread = true;
            control-center = {
              color = "primary";
              glyph = "snowflake";
            };
          };
          control_center = {
            sidebar_section = "none";
            hidden_tabs = [
              "media"
              "audio"
              "system"
              "weather"
              "calendar"
              "notifications"
            ];
            show_session_button = false;

            shortcuts = [
              { type = "wifi"; }
              { type = "bluetooth"; }
              { type = "caffeine"; }
              { type = "notification"; }
              { type = "clipboard"; }
              { type = "power_profile"; }
            ];
          };
          osd = {
            position = "bottom_left";
            position_vertical = "bottom_left";

            offset_x = 4;
            offset_y = 7;

            border_width = 3.0;
          };

          lockscreen_widgets.enabled = false;
          idle.pre_action_fade_seconds = 0;

          bluetooth.connection_notifications = true;
          location.address = "Shanghai, China";
          calendar.enabled = true;

          plugins.enabled = [
            "kenn/keybind-cheatsheet"
            "noctalia/kaomoji"
            "noctalia/translator"
          ];

          plugin_settings = {
            "kenn/keybind-cheatsheet".columns = 4;
            "noctalia/translator".target_lang = "zh_cn";
          };
        };
      };
    };
  };
}
