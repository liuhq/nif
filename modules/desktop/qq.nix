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
    systemd.user.services.qq = {
      description = "Tencent QQ";
      partOf = cfg.systemdTargets;
      after = cfg.systemdTargets;
      serviceConfig = {
        Type = "simple";
        ExecStart = "${lib.getExe' pkgs.qq "qq"}";
        Restart = "on-failure";
        Environment = [
          "LANG=zh_CN.UTF-8"
          "LC_ALL=zh_CN.UTF-8"
        ];
      };
      wantedBy = cfg.systemdTargets;
    };
  };
}
