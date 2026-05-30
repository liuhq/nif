{
  inputs,
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.dev.omp;
  inherit (myvar) userName;
  omp-pkg = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.omp;
  omp-wrapped = pkgs.writeShellScriptBin "omp" ''
    export PATH="${
      pkgs.lib.makeBinPath [
        pkgs.nodejs
        pkgs.python3
      ]
    }:$PATH"
    exec ${lib.getExe omp-pkg} "$@"
  '';
in
{
  options.mymod = {
    dev.omp = {
      enable = lib.mkEnableOption "Oh-My-Pi" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      omp-wrapped
    ];

    hjem.users.${userName} = {
      environment.sessionVariables = {
        PUPPETEER_EXECUTABLE_PATH = lib.getExe pkgs.google-chrome;
      };
    };
  };
}
