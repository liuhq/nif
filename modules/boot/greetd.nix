{
  lib,
  config,
  pkgs,
  myvar,
  ...
}:
let
  cfg = config.mymod.displayManager.greetd;
in
{
  options.mymod.displayManager.greetd = {
    enable = lib.mkEnableOption "greetd + tuigreet";
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --cmd '${lib.getExe' pkgs.niri "niri-session"} -l' --greeting 'NixOS' --time --remember --asterisks";
          user = myvar.userName;
        };
      };
      useTextGreeter = true;
    };
  };
}
