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
in
{
  imports = [ ];

  options.mymod = {
    dev.cuda = {
      enable = lib.mkEnableOption "CUDA dev" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    hjem.users.${userName} = {
      environment.sessionVariables = {
        CUDA_CACHE_PATH = "\${XDG_CACHE_HOME}/nv";
      };
    };
  };
}
