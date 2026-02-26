{
  config,
  pkgs,
  lib,
  myvar,
  paths,
  ...
}:
let
  inherit (myvar) userName;
  inherit (paths) external;
  cfg = config.mymod;
  hjemCfg = config.hjem.users.${userName};
in
{
  options.mymod = {
    zsh.enable = lib.mkEnableOption "zsh";
  };

  config = lib.mkIf cfg.zsh.enable {
    programs.zsh = {
      enable = true;
      histSize = 128000;
      histFile = "\${ZDOTDIR}/.zsh_history";
      enableCompletion = true;
      enableLsColors = true;
      autosuggestions.enable = true;
      autosuggestions.async = true;
      syntaxHighlighting.enable = true;
    };

    programs.zsh.interactiveShellInit = lib.readFile "${external}/zsh/zshrc";

    programs.zsh.shellAliases = {
      sudo = "sudo ";
      clr = "clear";
      ".." = "cd ..";

      ls = "ls --color=auto --human-readable --classify";
      lv = "ls --format=single-column";
      ll = "ls -l";
      la = "ls -lA";

      cp = "cp --verbose";
      mv = "mv --verbose";
      rm = "rm --verbose";
      mkdir = "mkdir --verbose";
      rmdir = "rmdir --verbose";
    };

    environment.sessionVariables = {
      ZDOTDIR = "${hjemCfg.xdg.config.directory}/zsh";
    };

    hjem.users.${userName} = {
      environment.sessionVariables = {
        ZDOTDIR = "${hjemCfg.xdg.config.directory}/zsh";
        PATH = [
          "\${XDG_CONFIG_HOME}/cargo/bin"
          "\${XDG_DATA_HOME}/pnpm"
        ];
      };
      files =
        let
          check = {
            environment = hjemCfg.environment.sessionVariables != { };
          };
        in
        {
          ".zshenv" = lib.mkIf check.environment {
            source = hjemCfg.environment.loadEnv;
          };
        };
    };
  };
}
