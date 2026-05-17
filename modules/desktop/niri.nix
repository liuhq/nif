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
      "niri/config.kdl".source = "${external}/niri/config.kdl";
      "niri/keybind.kdl".source = "${external}/niri/keybind.kdl";
      "niri/rule.kdl".source = "${external}/niri/rule.kdl";
      "niri/theme.kdl".source = "${external}/niri/theme.kdl";

    };

    environment.systemPackages = with pkgs; [
      xwayland-satellite
      nautilus
    ];
  };
}
