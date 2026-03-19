{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.dev.podman;
  inherit (myvar) userName;
in
{
  options.mymod = {
    dev.podman = {
      enable = lib.mkEnableOption "Podman environment" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        defaultNetwork.settings = {
          # Required for containers under podman-compose to be able to talk to each other.
          dns_enabled = true;
        };
        autoPrune = true;

        networkSocket.openFirewall = true;
      };

      oci-containers.backend = "podman";
    };

    hardware.nvidia-container-toolkit.enable = true;

    users.users.${userName}.extraGroups = [ "podman" ];
  };
}
