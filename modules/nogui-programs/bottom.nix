{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  inherit (myvar) userName;
in
{
  environment.systemPackages = [ pkgs.bottom ];

  hjem.users.${userName}.xdg.config.files = {
    "bottom/bottom.toml" = {
      generator = (pkgs.formats.toml { }).generate "bottom-config";
      value = {
        flags = {
          enable_cache_memory = true;
          hide_table_gap = true;
          process_memory_as_value = true;
          rate = 1000;
          show_table_scroll_position = true;
        };

        styles = {
          cpu = {
            all_entry_color = "#f4dbd6";
            avg_entry_color = "#ee99a0";
            cpu_core_colors = [
              "#ed8796"
              "#f5a97f"
              "#eed49f"
              "#a6da95"
              "#7dc4e4"
              "#c6a0f6"
            ];
          };
          memory = {
            ram_color = "#a6da95";
            cache_color = "#ed8796";
            swap_color = "#f5a97f";
            gpu_colors = [
              "#7dc4e4"
              "#c6a0f6"
              "#ed8796"
              "#f5a97f"
              "#eed49f"
              "#a6da95"
            ];
            arc_color = "#91d7e3";
          };
          network = {
            rx_color = "#a6da95";
            tx_color = "#ed8796";
            rx_total_color = "#91d7e3";
            tx_total_color = "#a6da95";
          };
          battery = {
            high_battery_color = "#a6da95";
            medium_battery_color = "#eed49f";
            low_battery_color = "#ed8796";
          };
          tables = {
            headers = {
              color = "#f4dbd6";
            };
          };
          graphs = {
            graph_color = "#a5adcb";
            legend_text = {
              color = "#a5adcb";
            };
          };
          widgets = {
            border_color = "#5b6078";
            selected_border_color = "#f5bde6";
            widget_title = {
              color = "#f0c6c6";
            };
            text = {
              color = "#cad3f5";
            };
            selected_text = {
              color = "#181926";
              bg_color = "#c6a0f6";
            };
            disabled_text = {
              color = "#24273a";
            };
          };
        };

        row = [
          {
            ratio = 30;
            child = [ { type = "cpu"; } ];
          }
          {
            ratio = 70;
            child = [
              {
                default = true;
                ratio = 4;
                type = "proc";
              }
              {
                ratio = 3;
                child = [
                  {
                    ratio = 4;
                    type = "mem";
                  }
                  {
                    ratio = 3;
                    type = "net";
                  }
                  {
                    ratio = 3;
                    type = "temp";
                  }
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
