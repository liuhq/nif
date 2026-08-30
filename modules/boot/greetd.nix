{
  lib,
  config,
  pkgs,
  myvar,
  inputs,
  ...
}:
let
  cfg = config.mymod.displayManager.greetd;
  inherit (myvar) userName;
in
{
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  options.mymod.displayManager.greetd = {
    enable = lib.mkEnableOption "greetd + tuigreet" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    # services.greetd = {
    #   enable = true;
    #   settings = {
    #     default_session = {
    #       command = "${pkgs.tuigreet}/bin/tuigreet --cmd '${lib.getExe' pkgs.niri "niri-session"} -l' --greeting 'NixOS' --time --remember --asterisks";
    #       user = myvar.userName;
    #     };
    #   };
    #   useTextGreeter = true;
    # };

    programs.noctalia-greeter = {
      enable = true;

      settings = {
        # session = {
        #   default = "";
        # };
        user.default = "${userName}";
        appearance = {
          scheme = "Nord";
          hide_logo = true;
          theme_mode = "dark";
          corner_radius_scale = 4;
          wallpaper = "${pkgs.my-wallpaper}/wallpaper.jpg";
        };
        idle.timeout = 0;
        cursor = {
          theme = "Bocchi";
          size = 36;
          path = "${pkgs.bocchi-dyn-cursor}/share/icons/Bocchi";
        };
        keyboard.layout = "us";
      };
    };
  };
}
