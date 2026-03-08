{
  lib,
  config,
  pkgs,
  paths,
  ...
}:
let
  cfg = config.mymod.network.mihomo;
  inherit (paths) external;
  geosite = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/liuhq/meta-rules-dat/release/geosite.dat";
    hash = "";
    pname = "geosite";
    version = "20260308";
  };
  geoip = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/liuhq/meta-rules-dat/release/geoip.dat";
    hash = "";
    pname = "geoip";
    version = "20260308";
  };
  country = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/liuhq/meta-rules-dat/release/country.mmdb";
    hash = "";
    pname = "country";
    version = "20260308";
  };
in
{
  options.mymod = {
    network.mihomo.enable = lib.mkEnableOption "Mihomo";
  };

  config = lib.mkIf cfg.enable {
    # networking.resolvconf.useLocalResolver = true;
    networking.nameservers = [ "127.0.0.1" ];

    services.mihomo = {
      enable = true;
      configFile = "/etc/mihomo/config.yaml";
      tunMode = true;
      webui = pkgs.metacubexd;
    };

    systemd.services.mihomo.serviceConfig =
      let
        cap = [
          ## tun mode
          "CAP_NET_ADMIN"
          ## necessary capabilities for rules about process information such as `process-name`
          "CAP_DAC_READ_SEARCH"
          "CAP_SYS_PTRACE"
          ## 127.0.0.1:53 DNS port binding
          "CAP_NET_BIND_SERVICE"
        ];
      in
      {
        ## Fix: unable to read files other than config.yaml
        ExecStartPre = pkgs.writeShellScript "mihomo-start-pre" ''
          install ''${CREDENTIALS_DIRECTORY}/config.yaml ''${STATE_DIRECTORY}/config.yaml
          install ''${CREDENTIALS_DIRECTORY}/proxies.yaml ''${STATE_DIRECTORY}/proxies.yaml
          install ${geosite} ''${STATE_DIRECTORY}/GeoSite.dat
          install ${geoip} ''${STATE_DIRECTORY}/GeolP.dat
          install ${country} ''${STATE_DIRECTORY}/Country.mmdb
        '';

        LoadCredential = [
          "proxies.yaml:${config.age.secrets.proxies.path}"
        ];

        AmbientCapabilities = lib.mkForce cap;
        CapabilityBoundingSet = lib.mkForce cap;
      };

    environment.etc."mihomo/config.yaml".source = "${external}/mihomo/config.yaml";
  };
}
