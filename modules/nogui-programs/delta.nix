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
        line-numbers = true;
        navigate = true;
        hyperlinks = true;
      };
      alias = {
        diff-side-by-side = "-c delta.features=side-by-side diff";
      };
      merge = {
        conflictStyle = "zdiff3";
      };
    };
}
