{
  config,
  pkgs,
  lib,
  myvar,
  paths,
  inputs,
  ...
}:
let
  cfg = config.mymod.desktop;
  inherit (myvar) userName;
  inherit (paths) external;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.which-key-wayland.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    hjem.users.${userName}.xdg.config.files = {
      "which-key-wayland/config.kdl".source = "${external}/which-key-wayland/config.kdl";
    };
  };
}
