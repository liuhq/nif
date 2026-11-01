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
    systemd.user.services.discord = {
      description = "Discord";
      partOf = cfg.systemdTargets;
      after = cfg.systemdTargets;
      serviceConfig = {
        Type = "simple";
        ExecStart = "${lib.getExe pkgs.discord}";
        Restart = "on-failure";
      };
      wantedBy = cfg.systemdTargets;
    };
  };
}
