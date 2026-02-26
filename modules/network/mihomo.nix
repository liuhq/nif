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
    environment.etc."proxies/tag.yaml".source = config.age.secrets.proxies.path;
  };
}
