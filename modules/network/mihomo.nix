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

    # /etc/mihomo/config.yaml
    environment.etc."mihomo/config.yaml".source = "${external}/mihomo/config.yaml";
    environment.etc."mihomo/proxies/tag.yaml".source = config.age.secrets.proxies.path;
    environment.etc."mihomo/GeoSite.dat".source = geosite;
    environment.etc."mihomo/GeolP.dat".source = geoip;
    environment.etc."mihomo/Country.mmdb".source = country;
  };
}
