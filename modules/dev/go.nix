{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.dev.go;
  inherit (myvar) userName;
  hjemCfg = config.hjem.users.${userName};
in
{
  imports = [ ];

  options.mymod = {
    dev.go = {
      enable = lib.mkEnableOption "GO environment" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    hjem.users.${userName} = {
      environment.sessionVariables = {
        GOPATH = "${hjemCfg.xdg.data.directory}/go";
        GOMODCACHE = "${hjemCfg.xdg.cache.directory}/go/mod";
      };
    };
  };
}
