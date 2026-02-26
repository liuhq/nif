{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mymod.network.networkd;
  toBoolStr = b: if b then "yes" else "no";
in
{
  options.mymod.network.networkd = {
    enable = lib.mkEnableOption "systemd-networkd";
    wired.requiredForOnline = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether this interface is required to be online during boot.";
    };
    wireless.requiredForOnline = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether this interface is required to be online during boot.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.network = {
      enable = true;

      networks = {
        "20-wired" = {
          matchConfig.Name = "en*";
          networkConfig.DHCP = "yes";
          linkConfig.RequiredForOnline = toBoolStr cfg.wired.requiredForOnline;
        };
        "25-wireless" = {
          matchConfig.Name = "wl*";
          networkConfig.DHCP = "yes";
          linkConfig.RequiredForOnline = toBoolStr cfg.wireless.requiredForOnline;
        };
      };
    };
  };
}
