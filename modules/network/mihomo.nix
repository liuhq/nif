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
    url = "https://raw.githubusercontent.com/liuhq/meta-rules-dat/168e4d93fef26761b8bdf0fbf989ddcbb3faf288/geosite.dat";
    hash = "sha256-po1eZf5o4K+3mqTo2xxFIo9jq5q90my30nyaBrk+Q1g=";
    pname = "geosite";
    version = "20260529";
  };
  geoip = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/liuhq/meta-rules-dat/168e4d93fef26761b8bdf0fbf989ddcbb3faf288/geoip.dat";
    hash = "sha256-LNqRGO6ZldXcFdNmYancMFNKYnK6aILAwVn3zgjwKIs=";
    pname = "geoip";
    version = "20260529";
  };
  country = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/liuhq/meta-rules-dat/168e4d93fef26761b8bdf0fbf989ddcbb3faf288/country.mmdb";
    hash = "sha256-l4RcIHTB8NyUZcd81PvOzotEZbmBNWi6f53xQ7ICZU8=";
    pname = "country";
    version = "20260529";
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

    # systemd.services.mihomo.wantedBy = lib.mkForce [ ];
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
          "proxies.yaml:${config.age.secrets.proxies-mihomo.path}"
        ];

        AmbientCapabilities = lib.mkForce cap;
        CapabilityBoundingSet = lib.mkForce cap;
      };

    environment.etc."mihomo/config.yaml".source = "${external}/mihomo/config.yaml";
  };
}
