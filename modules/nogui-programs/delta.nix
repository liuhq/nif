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
        true-color = "always";
        line-numbers = true;
        navigate = true;
        hyperlinks = true;

        dark = true;
        blame-palette = "#24273a #1e2030 #181926 #363a4f #494d64";
        commit-decoration-style = "\"#6e738d\" bold box ul";
        file-decoration-style = "#6e738d";
        file-style = "#cad3f5";
        hunk-header-decoration-style = "\"#6e738d\" box ul";
        hunk-header-file-style = "bold";
        hunk-header-line-number-style = "bold \"#a5adcb\"";
        hunk-header-style = "file line-number syntax";
        line-numbers-left-style = "#6e738d";
        line-numbers-minus-style = "bold \"#ed8796\"";
        line-numbers-plus-style = "bold \"#a6da95\"";
        line-numbers-right-style = "#6e738d";
        line-numbers-zero-style = "#6e738d";
        minus-emph-style = "bold syntax \"#6a485a\"";
        minus-style = "syntax \"#4c3a4c\"";
        plus-emph-style = "bold syntax \"#51655a\"";
        plus-style = "syntax \"#3e4b4c\"";
        map-styles = ''bold purple => syntax "#5c517c", bold blue => syntax "#47557b", bold cyan => syntax "#4a6475", bold yellow => syntax "#6a635d"'';
        syntax-theme = "Catppuccin Macchiato";

      };
      alias = {
        diff-side-by-side = "-c delta.features=side-by-side diff";
      };
      merge = {
        conflictStyle = "zdiff3";
      };
    };
}
