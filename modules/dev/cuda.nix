{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.dev.cuda;
  inherit (myvar) userName;
  hjemCfg = config.hjem.users.${userName};
in
{
  imports = [ ];

  options.mymod = {
    dev.cuda = {
      enable = lib.mkEnableOption "CUDA environment" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    hjem.users.${userName} = {
      environment.sessionVariables = {
        CUDA_CACHE_PATH = "${hjemCfg.xdg.cache.directory}/nv";
      };
    };
  };
}
