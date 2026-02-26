{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.mymod.desktop;
in
{
  config = lib.mkIf cfg.enable {
    systemd.user.services.cliphist = {
      description = "Clipboard management daemon";
      partOf = cfg.systemdTargets;
      after = cfg.systemdTargets;
      serviceConfig = {
        Type = "simple";
        ExecStart = "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --watch ${lib.getExe pkgs.cliphist} store";
        Restart = "on-failure";
      };
      wantedBy = cfg.systemdTargets;
    };
  };
}
