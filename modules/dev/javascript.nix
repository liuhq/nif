{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.dev.javascript;
  inherit (myvar) userName;
in
{
  imports = [ ];

  options.mymod = {
    dev.javascript = {
      enable = lib.mkEnableOption "use deno-ts as one of system scripts" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ deno ];

    hjem.users.${userName} = {
      environment.sessionVariables = {
        NPM_CONFIG_USERCONFIG = "\${XDG_CONFIG_HOME}/npm/npmrc";
      };

      xdg.config.files = {
        "npm/npmrc".source = pkgs.writeText "npm-config" ''
          prefix=''${XDG_DATA_HOME}/npm
          cache=''${XDG_CACHE_HOME}/npm
          init-module=''${XDG_CONFIG_HOME}/npm/config/npm-init.js
          logs-dir=''${XDG_STATE_HOME}/npm/logs
        '';
      };
    };
  };
}
