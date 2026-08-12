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
      aseprite
      crosspipe
      eyedropper
      game-devices-udev-rules
      gimp
      gnome-calculator
      gnome-characters
      inkscape
      kdePackages.kdenlive
      # krita
      inputs.nixpkgs-krita.legacyPackages.${pkgs.stdenv.hostPlatform.system}.krita
      ldtk
      libnotify
      lmms
      papers
      satty
      spotify
      tiled
    ];
  };
}
