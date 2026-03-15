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
    environment.systemPackages = [ pkgs.zed-editor.fhs ];

    hjem.users.${userName}.xdg.config.files = {
      "zed" = {
        source = "${external}/zed";
        permissions = "440";
      };
    };
  };
}
