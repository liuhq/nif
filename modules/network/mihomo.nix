{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mymod.network.mihomo;
  toYaml = pkgs.formats.yaml { };
  geositeDat = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/liuhq/meta-rules-dat/5f2e6703a7d64d6af2f23287bc516f1415514054/geosite.dat";
    hash = "sha256-DOXmV2fr277UKzzQe6XzFM7/vAQHdSNrXY4DoreML+4=";
    pname = "geosite";
    version = "20260612";
  };
  geoipDat = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/liuhq/meta-rules-dat/5f2e6703a7d64d6af2f23287bc516f1415514054/geoip.dat";
    hash = "sha256-fA4ONx3erKpBA4lV1Q6oac9PsfPc3/D3HC8NbVn8zOg=";
    pname = "geoip";
    version = "20260612";
  };
  countryMmdb = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/liuhq/meta-rules-dat/5f2e6703a7d64d6af2f23287bc516f1415514054/country.mmdb";
    hash = "sha256-wwIdTo6/fbolfJ5BNvaztrF1h9bWz3hV3yjoEm56Mlk=";
    pname = "country";
    version = "20260612";
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
      processesInfo = true;
      webui = pkgs.metacubexd;
    };

    # systemd.services.mihomo.wantedBy = lib.mkForce [ ];
    systemd.services.mihomo.serviceConfig =
      let
        cap = [
          ## 127.0.0.1:53 DNS port binding
          "CAP_NET_BIND_SERVICE"
        ];
      in
      {
        ## Fix: unable to read files other than config.yaml
        ExecStartPre = pkgs.writeShellScript "mihomo-start-pre" ''
          install ${config.age.secrets.proxies.path} ''${STATE_DIRECTORY}/proxies
          install ${geositeDat} ''${STATE_DIRECTORY}/GeoSite.dat
          install ${geoipDat} ''${STATE_DIRECTORY}/GeolP.dat
          install ${countryMmdb} ''${STATE_DIRECTORY}/Country.mmdb
        '';

        Environment = [
          "SAFE_PATHS=/etc/mihomo"
        ];

        AmbientCapabilities = cap;
        CapabilityBoundingSet = cap;
      };

    # environment.etc."mihomo/config.yaml".source = "${external}/mihomo/config.yaml";
    environment.etc."mihomo/config.yaml".source =
      let
        outDirect = "DIRECT";
        outDirectNoResolve = "DIRECT,no-resolve";
        outProxy = "Proxy";
        healthCheck = {
          url = "https://8.8.8.8/generate_204";
          interval = 300;
          timeout = 3000;
          lazy = true;
          expected-status = 204;
        };
        subNodes = "SUB_NODES";
        use = [ subNodes ];
        selectNode =
          name: proxies:
          {
            inherit name proxies;
            type = "select";
          }
          // healthCheck;
        countryNode =
          cc:
          let
            CC = lib.toUpper cc;
          in
          [
            (selectNode CC [
              "${CC}-Balance"
              "${CC}-Auto"
              "${CC}-Filter"
            ])
            (
              {
                name = "${lib.toUpper cc}-Balance";
                type = "load-balance";
                inherit use;
                filter = "(?i)${cc}";
                strategy = "consistent-hashing";
              }
              // healthCheck
            )
            (
              {
                name = "${lib.toUpper cc}-Auto";
                type = "url-test";
                inherit use;
                filter = "(?i)${cc}";
                tolerance = 80;
              }
              // healthCheck
            )
            (
              {
                name = "${lib.toUpper cc}-Filter";
                type = "select";
                inherit use;
                filter = "(?i)${cc}";
              }
              // healthCheck
            )
          ];
        rule =
          ru: ta: out:
          "${ru},${ta},${out}";
        domain = ta: out: rule "DOMAIN" ta out;
        domainSuffix = ta: out: rule "DOMAIN-SUFFIX" ta out;
        geosite = ta: out: rule "GEOSITE" ta out;
        geoip = ta: out: rule "GEOIP" ta out;
        dstPort = ta: out: rule "DST-PORT" ta out;
        processName = ta: out: rule "PROCESS-NAME" ta out;
      in
      toYaml.generate "mihomo-config.yaml" {
        ## General
        log-level = "info";
        mode = "rule";
        ipv6 = true;
        allow-lan = false;
        unified-delay = true;
        tcp-concurrent = true;
        keep-alive-interval = 15;
        keep-alive-idle = 300;
        disable-keep-alive = false;
        find-process-mode = "strict";
        profile = {
          store-selected = true;
          store-fake-ip = true;
        };

        ## External
        external-controller = "127.0.0.1:9090";
        external-controller-cors = {
          allow-origins = [ "*" ];
          allow-private-network = true;
        };
        secret = "404@mihomo";

        ## GEO
        geodata-mode = false;
        geodata-loader = "standard";
        geo-auto-update = false;

        ## DNS
        hosts = {
          "services.googleapis.cn" = "services.googleapis.com";
          "google.cn" = "google.com";
        };
        dns = {
          enable = true;
          cache-algorithm = "arc";
          ipv6 = true;
          listen = "127.0.0.1:53";
          enhanced-mode = "redir-host";
          respect-rules = true;
          proxy-server-nameserver = [
            "https://223.5.5.5/dns-query"
            "https://223.6.6.6/dns-query"
          ];
          direct-nameserver = [
            "https://223.5.5.5/dns-query"
            "https://223.6.6.6/dns-query"
          ];
          direct-nameserver-follow-policy = true;
          nameserver-policy = {
            "geosite:cn,private,biliintl,bilibili,tld-cn,category-games-cn,category-games@cn,steam@cn" = [
              "https://223.5.5.5/dns-query"
              "https://223.6.6.6/dns-query"
            ];
          };
          nameserver = [
            "https://8.8.8.8/dns-query#Proxy"
            "https://9.9.9.9/dns-query#Proxy"
          ];
        };

        ## Sniffer
        sniffer = {
          enable = true;
          force-dns-mapping = true;
          parse-pure-ip = true;
          override-destination = false;
          sniff = {
            HTTP = {
              ports = [
                80
                "8080-8880"
              ];
              override-destination = true;
            };
            TLS = {
              ports = [
                443
                8443
              ];
            };
            QUIC = {
              ports = [
                443
                8443
              ];
            };
          };
        };

        ## Inbound - TUN
        tun = {
          enable = true;
          stack = "mixed";
          device = "mihomo-tun";
          auto-route = true;
          auto-redirect = true;
          auto-detect-interface = true;
          strict-route = false;
          disable-icmp-forwarding = true;
          mtu = 9000;
          endpoint-independent-nat = false;
          dns-hijack = [
            "any:53"
            "tcp://any:53"
          ];
        };

        ## Providers
        proxy-providers = {
          ${subNodes} = {
            type = "file";
            path = "./proxies";
            proxy = outDirect;
            filter = "(?i)1x";
          };
        };

        ## Proxy Groups
        proxy-groups = [
          (selectNode outProxy [
            "JP"
            "HK"
            "US"
            "FR"
            outDirect
          ])
          (selectNode "Games" [
            outDirect
            "JP"
            "HK"
            "US"
          ])
          (selectNode "Spotify" [
            "JP"
            "HK"
            outDirect
          ])
          (selectNode "GooglePlay" [
            "JP"
            "US"
            outDirect
          ])
          (selectNode "Dlsite" [
            "HK"
            "JP"
            outDirect
          ])
        ]
        ++ (countryNode "jp")
        ++ (countryNode "hk")
        ++ (countryNode "us")
        ++ (countryNode "fr");

        ## Rules
        rules = [
          (domain "ad.qq.com" outDirect)
          (domain "sso.e.qq.com" outDirect)

          (geosite "category-ads-all" "REJECT")
          (geosite "private" outDirect)
          (geoip "private" outDirectNoResolve)
          (dstPort "22" outDirect) # https://github.com/vernesong/OpenClash/issues/1960#issuecomment-1115732292
          (dstPort "587" outDirect)
          (processName ".qbittorrent-wrapped" outDirectNoResolve)
          ## steam proton
          (processName "wineserver" "Games,no-resolve")

          (geosite "dlsite" "Dlsite")
          (geosite "google-play" "GooglePlay")
          (geosite "spotify" "Spotify")

          (geosite "biliintl" outDirect)
          (geosite "bilibili" outDirect)
          (geosite "tracker" outDirect)
          (geosite "category-public-tracker" outDirect)
          (geosite "category-games-cn" outDirect)
          (geosite "category-games@cn" outDirect)
          (geosite "steam@cn" outDirect)

          (geosite "category-games" "Games")

          (domainSuffix "cn" outDirect)
          (geosite "cn" outDirect)
          (geoip "CN" outDirect)

          "MATCH,${outProxy}"
        ];
      };
  };
}
