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
  cfg = config.mymod.fish;
  hjemCfg = config.hjem.users.${userName};
in
{
  options.mymod = {
    fish.enable = lib.mkEnableOption "fish";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
    ];

    programs.fish = {
      enable = true;
      shellAbbrs = {
        gs = "git switch";
        ga = "git add";
        gc = "git commit";
        npu = "nix-prefetch-url";
      };
      shellAliases = {
        clr = "clear";
        cp = "cp --verbose";
        mv = "mv --verbose";
        rm = "rm --verbose";
        mkdir = "mkdir --verbose";
        rmdir = "rmdir --verbose";
      };
      interactiveShellInit = ''
        fish_config theme choose nord 

        set -g fish_greeting
      '';
    };

    hjem.users.${userName} = {
      xdg.config.files = {
        "fish/functions/runspt.fish".source = "${external}/fish/functions/runspt.fish";
        "fish/completions/runspt.fish".source = "${external}/fish/completions/runspt.fish";
        "fish/conf.d/hjem-environment-variables.fish" =
          lib.mkIf (hjemCfg.environment.sessionVariables != { })
            {
              text = ''
                ${lib.concatMapAttrsStringSep "\n" (
                  n: v:
                  if n == "PATH" then
                    ''
                      set -gx PATH ${lib.concatMapStringsSep " " (p: "\"${p}\"") v} $PATH
                    ''
                  else
                    "set -gx ${lib.escapeShellArg n} ${lib.escapeShellArg (lib.toString v)}"
                ) hjemCfg.environment.sessionVariables}
              '';
            };
      };
    };
  };
}
