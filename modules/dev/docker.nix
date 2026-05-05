{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.mymod.dev.docker;
in
{
  options.mymod = {
    dev.docker = {
      enable = lib.mkEnableOption "Docker environment" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      storageDriver = "overlay2";
      daemon.settings = {
        dns = [ "1.1.1.1" ];
        log-driver = "journald";
        features.cdi = true;
      };
      autoPrune = {
        enable = true;
        dates = "14d";
      };
    };

    hardware.nvidia-container-toolkit.enable = true;
  };
}
