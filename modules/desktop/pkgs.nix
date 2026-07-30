{
  config,
  pkgs,
  lib,
  inputs,
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
      crosspipe
      eyedropper
      game-devices-udev-rules
      gnome-calculator
      gnome-characters
      inkscape
      kdePackages.kdenlive
      # krita
      inputs.nixpkgs-krita.legacyPackages.${pkgs.stdenv.hostPlatform.system}.krita
      ldtk
      lmms
      papers
      satty
      spotify
      tiled
    ];
  };
}
