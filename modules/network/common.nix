{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.network;
in
{
  options.mymod =
    let
      canonicalizePortList = ports: lib.unique (builtins.sort builtins.lessThan ports);
    in
    {
      network.firewall = {
        allowedTCPPorts = lib.mkOption {
          type = lib.types.listOf lib.types.port;
          default = [ ];
          apply = canonicalizePortList;
          example = [
            22
            80
          ];
          description = ''
            List of TCP ports on which incoming connections are
            accepted.
          '';
        };
        allowedUDPPorts = lib.mkOption {
          type = lib.types.listOf lib.types.port;
          default = [ ];
          apply = canonicalizePortList;
          example = [ 53 ];
          description = ''
            List of open UDP ports.
          '';
        };
      };
    };

  config = {
    networking = {
      inherit (myvar) hostName;

      useDHCP = false;
      dhcpcd.enable = false;
    };

    networking.firewall = {
      enable = true;
      inherit (cfg.firewall) allowedTCPPorts allowedUDPPorts;
    };
  };
}
