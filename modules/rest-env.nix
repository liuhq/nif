{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  inherit (myvar) userName;
in
{
  environment.sessionVariables = {
    MANPAGER = "nvim +Man!";
    MANROFFOPT = "-c";
  };

  hjem.users.${userName}.environment.sessionVariables = {
    BROWSER = "${lib.getExe pkgs.chromium}";
    TERMINAL = "${lib.getExe pkgs.foot}";
  };
}
