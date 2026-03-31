{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.desktop;
  inherit (myvar) userName;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      protonplus
    ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      protontricks.enable = true;
      extest.enable = true;
      extraPackages = with pkgs; [
        gamescope
      ];
    };

    programs.gamemode.enable = true;

    hardware.steam-hardware.enable = true;
  };
}
