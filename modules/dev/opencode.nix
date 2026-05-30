{
  inputs,
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.dev.opencode;
  inherit (myvar) userName;
  completionRepo = pkgs.fetchFromGitHub {
    owner = "PEMessage";
    repo = "opencode-zsh-completion";
    rev = "9ec78561db3ab2c8ea0011dda0cec351faa9562e";
    hash = "sha256-IIfKdJMB7g0FFG05CKsB/L4S+TuHKUgUw/VWCzLDlNA=";
  };
in
{
  options.mymod = {
    dev.opencode = {
      enable = lib.mkEnableOption "OpenCode" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode
    ];

    environment.sessionVariables = {
      OPENCODE_DISABLE_LSP_DOWNLOAD = "true";
    };

    hjem.users.${userName}.xdg.config.files = {
      "zsh/completions/_opencode".source = "${completionRepo}/_opencode";
    };
  };
}
