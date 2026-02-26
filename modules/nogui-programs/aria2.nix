{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  inherit (myvar) userName;
in
{
  environment.systemPackages = [ pkgs.aria2 ];

  hjem.users.${userName}.xdg.config.files = {
    "aria2/aria2.conf".source = pkgs.writeText "aria2-config" ''
      continue
      dir=/home/${userName}/downloads
      file-allocation=falloc
      log-level=warn
      max-connection-per-server=4
      min-split-size=5M
    '';
  };
}
