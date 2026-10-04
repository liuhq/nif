{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.dev.distrobox;
  inherit (myvar) userName;
  hjemCfg = config.hjem.users.${userName};
in
{
  options.mymod = {
    dev.distrobox = {
      enable = lib.mkEnableOption "Distrobox" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };

    environment.systemPackages = [ pkgs.distrobox ];

    users.users.${userName} = {
      extraGroups = [ "podman" ];
      subGidRanges = [
        {
          count = 65536;
          startGid = 100000;
        }
      ];
      subUidRanges = [
        {
          count = 65536;
          startUid = 100000;
        }
      ];
    };

    hjem.users.${userName}.xdg.config.files."distrobox/distrobox.conf".text = ''
      container_user_custom_home="${hjemCfg.xdg.data.directory}/distrobox-home"
    '';
  };
}
