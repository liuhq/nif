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
    environment.systemPackages = [
      (pkgs.mpv.override {
        scripts = [
          pkgs.mpvScripts.uosc
          pkgs.mpvScripts.thumbfast
        ];
      })
    ];

    hjem.users.${userName}.xdg.config.files = {
      "mpv".source = "${external}/mpv";
    };
  };
}
