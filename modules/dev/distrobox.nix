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

    hjem.users.${userName}.xdg.config.files."distrobox/distrobox.conf".text = ''
      container_user_custom_home="$HOME/.local/share/distrobox-home"
    '';
  };
}
