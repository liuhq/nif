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
  environment.systemPackages = [ pkgs.gnupg ];

  hjem.users.${userName} = {
    environment.sessionVariables = {
      GNUPGHOME = "\${XDG_CONFIG_HOME}/gnupg";
      GPG_TTY = "\$(tty)";
    };
  };
}
