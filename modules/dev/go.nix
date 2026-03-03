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
        GOPATH = "\${XDG_DATA_HOME}/go";
        GOMODCACHE = "\${XDG_CACHE_HOME}/go/mod";
      };
    };
  };
}
