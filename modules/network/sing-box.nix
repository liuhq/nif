{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.mymod.network.sing-box;
  fetchRuleSetList =
    {
      commit,
      version,
      geoip ? false,
    }:
    rs:
    lib.mapAttrsToList (tag: hash: {
      type = "local";
      inherit tag;
      format = "binary";
      path = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/liuhq/sing-${
          if geoip then "geoip" else "geosite"
        }/${commit}/${tag}.srs";
        inherit hash version;
        pname = tag;
      };
    }) rs;
  geoipRuleSet =
    fetchRuleSetList
      {
        commit = "86ae2ec85f07e08140bd0638588e42055c2cd731";
        version = "20260607";
        geoip = true;
      }
      {
        geoip-cn = "sha256-jpkBok3/pEmCt8b/K6IOY7juX9fqMEEGB+YesMxqhE0=";
      };
  geositeRuleSet =
    fetchRuleSetList
      {
        commit = "99c2cc57bc989b6634ff299cef3c83b8a9b78ed0";
        version = "20260607";
      }
      {
        geosite-private = "sha256-JgSRJD4CZuW6VD9QnKfxOwfW9MLCat4/Z13eoWYfMhM=";
        geosite-cn = "sha256-h35AKVZ7ehmQtm/tVoAlpIZAN4OVyG7JiumEILRyLtM=";
        geosite-tld-cn = "sha256-ebbmc9Ix3N6o57HCiqnPnjNfAfARChMqfQXyJ2KjDl4=";
        geosite-category-ads-all = "sha256-z/1daqMPmkOM26sOxls9IxEF1JKMWVwPhY94rWu+j8A=";
        geosite-steam = "sha256-FSJSud3NQodlWUlcnxsV53pE2aWL9eW+RLEVWSxB3pE=";
        "geosite-steam@cn" = "sha256-cT8QeNgklyAyL529mMV/10pmUf8XIFqu9BA/7hCrnD8=";
        geosite-spotify = "sha256-5hW7CcBhC5PrmSPaOLP6rEBeLXeYWlUDKxmcZe/GyZY=";
        geosite-dlsite = "sha256-LDv8ChyBF0znJNbWavLLsLxyBWtnRR/rqYKbZGzD5AU=";
        "geosite-category-ai-!cn" = "sha256-BnqLMQV5j/nEpuiBKpW3xPIld5Ewy7dOSeZbDpPSJrE=";
        geosite-category-public-tracker = "sha256-Io/UuKsfaFL1lH52dFCLOkajAfuVu9/YFJg+vhHjD+c=";
        geosite-category-games = "sha256-08p0zu0rx1xVcj4nCU/iy7WgClLZdk/WX9jv37BQYjQ=";
        geosite-category-games-cn = "sha256-l78Sfpn/1Qga6wZBIcsZSMoKUuNvKyMtu6BU5BXrftI=";
        "geosite-category-games@cn" = "sha256-oqGIk93NM9onWhfWNo1Q+06wpaShmR88wS7QxDvvgak=";
        geosite-category-cdn-cn = "sha256-6keGpzbykMxHnqv4dwdzoY+gWGAfOgmOYVOcye/EA9I=";
        geosite-bilibili = "sha256-H8YM6r8SRCEMSSfIKg4xY8Hw9zl6l6MTTNT4KElYtXs=";
        geosite-bilibili-cdn = "sha256-wQSjIhC8ocpiRG0p7wa7DPSF9RAf7+knl9avAK521AE=";
      };
in
{
  options.mymod = {
    network.sing-box.enable = lib.mkEnableOption "sing-box";
  };

  config = lib.mkIf cfg.enable {
    services.sing-box.enable = true;
    services.sing-box.package =
      inputs.nixpkgs-sing-box.legacyPackages.${pkgs.stdenv.hostPlatform.system}.sing-box;

    services.sing-box.settings = {
      log = {
        level = "info";
      };
      experimental = {
        cache_file = {
          enabled = true;
          path = "cache.db";
        };
        clash_api = {
          external_controller = "127.0.0.1:9090";
          external_ui = pkgs.metacubexd;
          secret = "404@mihomo";
          access_control_allow_private_network = true;
        };
      };
      dns = {
        servers = [
          {
            tag = "google-dns";
            type = "https";
            server = "8.8.8.8";
            detour = "proxy";
          }
          {
            tag = "ali-dns";
            type = "tls";
            server = "223.5.5.5";
          }
        ];
        rules = [
          {
            domain = [
              "ad.qq.com"
              "sso.e.qq.com"
            ];
            action = "route";
            server = "ali-dns";
          }
          {
            rule_set = "geosite-category-ads-all";
            action = "reject";
          }
          {
            rule_set = [
              "geosite-private"
              "geosite-category-cdn-cn"
              "geosite-bilibili-cdn"
              "geosite-bilibili"
              "geosite-category-games@cn"
              "geosite-category-games-cn"
              "geosite-tld-cn"
              "geosite-cn"
            ];
            action = "route";
            server = "ali-dns";
          }
        ];
        final = "google-dns";
        strategy = "prefer_ipv4";
      };
      inbounds = [
        {
          type = "tun";
          tag = "tun-in";
          interface_name = "sing-box-tun";
          address = [ "198.18.0.1/30" ];
          auto_route = true;
          auto_redirect = true;
          strict_route = true;
        }
      ];
      outbounds = {
        _secret = config.age.secrets.proxies.path;
        quote = false;
      };
      route = {
        rules = [
          {
            action = "sniff";
          }
          {
            type = "logical";
            mode = "or";
            rules = [
              {
                protocol = "dns";
              }
              {
                port = 53;
              }
            ];
            action = "hijack-dns";
          }
          {
            ip_is_private = true;
            action = "route";
            outbound = "direct-out";
          }
          {
            port = [
              22 # https://github.com/vernesong/OpenClash/issues/1960#issuecomment-1115732292
              587
            ];
            action = "route";
            outbound = "direct-out";
          }
          {
            clash_mode = "direct";
            outbound = "direct-out";
          }
          {
            domain = [
              "ad.qq.com"
              "sso.e.qq.com"
            ];
            action = "route";
            outbound = "direct-out";
          }
          {
            rule_set = "geosite-category-ads-all";
            action = "reject";
          }
          # steam proton
          {
            process_name = "wineserver";
            action = "route";
            outbound = "game";
          }
          {
            rule_set = [
              "geosite-steam"
              "geosite-category-games"
            ];
            action = "route";
            outbound = "game";
          }
          {
            rule_set = "geosite-spotify";
            action = "route";
            outbound = "jp";
          }
          {
            rule_set = "geosite-dlsite";
            action = "route";
            outbound = "hk";
          }
          {
            rule_set = "geosite-category-ai-!cn";
            action = "route";
            outbound = "ai";
          }
          {
            process_name = [
              "frpc"
              "qbittorrent"
            ];
            action = "route";
            outbound = "direct-out";
          }
          {
            domain_suffix = [ ".cn" ];
            action = "route";
            outbound = "direct-out";
          }
          {
            rule_set = [
              "geosite-private"
              "geosite-category-cdn-cn"
              "geosite-bilibili"
              "geosite-bilibili-cdn"
              "geosite-category-games-cn"
              "geosite-category-games@cn"
              "geosite-category-public-tracker"
              "geosite-steam@cn"
              "geosite-tld-cn"
              "geosite-cn"
              "geoip-cn"
            ];
            action = "route";
            outbound = "direct-out";
          }
        ];
        final = "proxy";
        default_domain_resolver = "ali-dns";
        auto_detect_interface = true;
        find_process = true;
        rule_set = geoipRuleSet ++ geositeRuleSet;
      };
    };
  };
}
