{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.mymod.desktop;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libnotify

      aseprite
      eyedropper
      game-devices-udev-rules
      gnome-calculator
      gnome-characters
      helvum
      papers
    ];
  };
}
