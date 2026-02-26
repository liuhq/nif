{
  config,
  pkgs,
  lib,
  myvar,
  paths,
  ...
}:
let
  inherit (myvar) userName;
  inherit (paths) external;
in
{
  environment.systemPackages = [ pkgs.aerc ];

  hjem.users.${userName}.xdg.config.files = {
    "aerc".source = "${external}/aerc";
  };
}
