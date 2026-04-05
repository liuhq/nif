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
    environment.systemPackages = with pkgs; [
      zsh-completions
    ];

    programs.zsh = {
      enable = true;
      histSize = 128000;
      histFile = "${hjemCfg.xdg.cache.directory}/.zsh_history";
      setOptions = [
        "HIST_IGNORE_DUPS"
        "HIST_EXPIRE_DUPS_FIRST"
        "APPEND_HISTORY"
        "AUTO_CD"
        "AUTO_PUSHD"
        "PUSHD_IGNORE_DUPS"
        "PUSHD_SILENT"
        "NULL_GLOB"
        "EXTENDED_GLOB"
      ];
      enableCompletion = true;
      enableBashCompletion = true;
      enableGlobalCompInit = false; # use custom fpath
      enableLsColors = true;
      autosuggestions.enable = true;
      autosuggestions.async = true;
      syntaxHighlighting.enable = true;
    };

    programs.zsh.interactiveShellInit = lib.readFile "${external}/zsh/init_zshrc";

    programs.zsh.shellAliases = {
      sudo = "sudo ";
      clr = "clear";

      ## use eza instead of ls
      # ls = "ls --color=auto --human-readable --classify";
      # lv = "ls --format=single-column";
      # ll = "ls -l";
      # la = "ls -lA";

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
          "$PATH"
        ];
        KEYTIMEOUT = 5;
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#616E88";
      };

      xdg.config.files =
        let
          check = {
            environment = hjemCfg.environment.sessionVariables != { };
          };
          collect =
            dir:
            lib.mapAttrs' (
              k: _:
              lib.nameValuePair "${dir}/${k}" {
                source = "${external}/${dir}/${k}";
              }
            ) (lib.readDir "${external}/${dir}");
        in
        {
          "zsh/.zshenv" = lib.mkIf check.environment {
            source = hjemCfg.environment.loadEnv;
          };
          "zsh/.zshrc".text = ''
            bindkey -v

            #############################
            ### Enable autocompletion ###
            #############################
            fpath=($ZDOTDIR/completions $fpath)

            autoload -U compinit && compinit

            #######################
            ### Plugins & Tools ###
            #######################
            zstyle ':completion:*' menu select
            zstyle ':completion:*' use-cache true
            zstyle ':completion:*' cache-path "${hjemCfg.xdg.cache.directory}/.zcompcache"
            zstyle ':completion:*' rehash true
            zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS} "ma=48;2;59;66;82;38;2;136;192;208"

            compdef _gdb rust-gdb

            SCRIPT_DIR="$ZDOTDIR/zsh.d"
            if [[ -d "$SCRIPT_DIR" ]]; then
              for script in "$SCRIPT_DIR"/*; do
                if [[ -r "$script" ]]; then
                  source "$script"
                fi
              done
            fi
          '';
        }
        // collect "zsh/zsh.d";
      # // collect "zsh/completions";
    };
  };
}
