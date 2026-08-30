{
  inputs,
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.dev.chatgpt;
  cfgDesktop = config.mymod.desktop;
  inherit (myvar) userName;
in
{
  options.mymod = {
    dev.chatgpt = {
      enable = lib.mkEnableOption "ChatGPT and Codex" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex
    ]
    ++ lib.lists.optionals cfgDesktop.enable [
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.chatgpt
    ];
  };
}
