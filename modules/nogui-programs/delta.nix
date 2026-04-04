{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = [ pkgs.delta ];

  mymod.programs.git.settings =
    let
      deltaCommand = lib.getExe pkgs.delta;
    in
    {
      core = {
        pager = deltaCommand;
      };
      interactive = {
        diffFilter = "${deltaCommand} --color-only";
      };
      delta = {
        dark = true;
        true-color = "always";
        syntax-theme = "Nord";
        line-numbers = true;
        navigate = true;
        hyperlinks = true;

        blame-palette = "#2E3440 #3B4252 #434C5E #4C566A #3B4252";
        commit-decoration-style = "\"#4C566A\" bold box ul";
        file-decoration-style = "#4C566A";
        file-style = "#D8DEE9";
        hunk-header-decoration-style = "\"#4C566A\" box ul";
        hunk-header-file-style = "bold";
        hunk-header-line-number-style = "bold \"#E5E9F0\"";
        hunk-header-style = "file line-number syntax";
        line-numbers-left-style = "#4C566A";
        line-numbers-minus-style = "bold \"#BF616A\"";
        line-numbers-plus-style = "bold \"#A3BE8C\"";
        line-numbers-right-style = "#4C566A";
        line-numbers-zero-style = "#4C566A";
        minus-emph-style = "bold syntax \"#97555F\""; # blend nord11 and nord0
        minus-style = "syntax \"#56404B\""; # blend nord11 and nord0
        plus-emph-style = "bold syntax \"#788C70\""; # blend nord14 and nord0
        plus-style = "syntax \"#434D4E\""; # blend nord14 and nord0
        map-styles = ''bold purple => syntax "#4d4356", bold blue => syntax "#3a4555", bold cyan => syntax "#3a4d4f", bold yellow => syntax "#57524a"'';
      };
      alias = {
        diff-side-by-side = "-c delta.features=side-by-side diff";
      };
      merge = {
        conflictStyle = "zdiff3";
      };
    };
}
