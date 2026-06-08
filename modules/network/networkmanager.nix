{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.network.networkmanager;
  mihomoCfg = config.mymod.network.mihomo;
in
{
  options.mymod.network.networkmanager = {
    enable = lib.mkEnableOption "NetworkManager";
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager = {
      enable = true;
      dns = lib.mkIf mihomoCfg.enable "none";
      wifi = {
        backend = "iwd";
      };
    };

    # https://wiki.nixos.org/wiki/Iwd#iwd_as_backend_for_NetworkManager
    networking.wireless.iwd.settings = {
      General = {
        AddressRandomization = "once";
      };
    };

    users.users.${myvar.userName}.extraGroups = [ "networkmanager" ];
  };
}
