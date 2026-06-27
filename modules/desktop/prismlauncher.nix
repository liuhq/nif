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
    environment.systemPackages = [
      (pkgs.prismlauncher.override {
        additionalPrograms = [ pkgs.ffmpeg pkgs.mmcai-rs ];

        jdks = [
          pkgs.zulu17
          pkgs.zulu21
          pkgs.zulu25
        ];
      })
    ];
  };
}
