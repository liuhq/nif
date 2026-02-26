{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.desktop;
  inherit (myvar) userName;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.imv ];

    hjem.users.${userName}.xdg.config.files = {
      "imv/config".source = pkgs.writeText "imv-config" ''
        [binds]
        n=next
        p=prev
      '';
    };
  };
}
