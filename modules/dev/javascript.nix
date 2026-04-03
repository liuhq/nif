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
  hjemCfg = config.hjem.users.${userName};
in
{
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
      environment.sessionVariables =
        let
          DENO_INSTALL_ROOT = "\${HOME}/.local/deno/bin";
        in
        {
          NPM_CONFIG_USERCONFIG = "${hjemCfg.xdg.config.directory}/npm/npmrc";

          DENO_DIR = "${hjemCfg.xdg.cache.directory}/deno";
          inherit DENO_INSTALL_ROOT;

          PATH = [ DENO_INSTALL_ROOT ];
        };

      xdg.config.files = {
        "npm/npmrc".source = pkgs.writeText "npm-config" ''
          prefix=${hjemCfg.xdg.data.directory}/npm
          cache=${hjemCfg.xdg.cache.directory}/npm
          init-module=${hjemCfg.xdg.config.directory}/npm/config/npm-init.js
          logs-dir=${hjemCfg.xdg.state.directory}/npm/logs
        '';
        "zsh/completions/_pnpm".source = "${pkgs.pnpm}/share/zsh/site-functions/_pnpm";
        "zsh/zsh.d/_npm".source = "${pkgs.nodejs}/lib/node_modules/npm/lib/utils/completion.sh";
      };
    };
  };
}
