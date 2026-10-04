{
  lib,
  config,
  pkgs,
  myvar,
  ...
}:
let
  cfg = config.mymod.displayManager.greetd;
  inherit (myvar) userName;
in
{
  options.mymod.displayManager.greetd = {
    enable = lib.mkEnableOption "greetd + tuigreet" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.noctalia-greeter = {
      enable = true;
      cursorTheme = {
        name = "Bocchi";
        package = pkgs.bocchi-dyn-cursor;
      };
      settings = {
        session.default = "niri";
        user.default = "${userName}";
        appearance = {
          scheme = "Nord";
          hide_logo = true;
          scheme_selector_position = "hidden";
          theme_mode = "dark";
          corner_radius_scale = 4;
          wallpaper = {
            path = "${pkgs.my-wallpaper}/wallpaper.jpg";
          };
        };
        cursor = {
          theme = "Bocchi";
          size = 36;
        };
        idle.timeout = 0;
        keyboard.layout = "us";
      };
    };
  };
}
