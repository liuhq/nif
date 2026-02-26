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
    systemd.user.services.telegram-desktop = {
      description = "Telegram Desktop";
      partOf = cfg.systemdTargets;
      after = cfg.systemdTargets;
      serviceConfig = {
        Type = "simple";
        ExecStart = "${lib.getExe pkgs.telegram-desktop}";
        Restart = "on-failure";
      };
      wantedBy = cfg.systemdTargets;
    };
  };
}
