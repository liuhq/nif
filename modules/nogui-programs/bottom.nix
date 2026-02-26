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
          theme = "nord";
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
