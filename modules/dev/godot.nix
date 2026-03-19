{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.mymod.dev.godot;
in
{
  options.mymod = {
    dev.godot = {
      enable = lib.mkEnableOption "Godot environment" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.godot ];
  };
}
