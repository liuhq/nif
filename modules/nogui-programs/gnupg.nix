{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  inherit (myvar) userName;
  hjemCfg = config.hjem.users.${userName};
in
{
  programs.gnupg.agent.enable = true;

  hjem.users.${userName} = {
    environment.sessionVariables = {
      GNUPGHOME = "${hjemCfg.xdg.config.directory}/gnupg";
      GPG_TTY = "\$(tty)";
    };
  };
}
