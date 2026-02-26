{
  config,
  pkgs,
  lib,
  myvar,
  paths,
  ...
}:
let
  cfg = config.mymod.desktop;
  inherit (myvar) userName;
  inherit (paths) external;
in
{
  config = lib.mkIf cfg.enable {
    programs.niri = {
      enable = true;
      useNautilus = true;
    };

    hjem.users.${userName}.xdg.config.files = {
      "niri".source = "${external}/niri";
    };

    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
  };
}
