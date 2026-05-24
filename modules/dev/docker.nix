{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.dev.docker;
  inherit (myvar) userName;
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

    environment.systemPackages = [ pkgs.distrobox ];

    hjem.users.${userName}.xdg.config.files."distrobox/distrobox.conf".text = ''
      container_user_custom_home="$HOME/.local/share/distrobox-home"
    '';
  };
}
