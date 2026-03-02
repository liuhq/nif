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
  environment.systemPackages = [ pkgs.neovim ];

  environment.shellAliases = {
    viro = "nvim -R";
  };

  environment.sessionVariables.EDITOR = lib.mkOverride 900 "nvim";

  # On most NixOS configurations /share is already included, so it includes
  # this directory as well. But  This makes sure that /share/nvim/site paths
  # from other packages will be used by neovim.
  environment.pathsToLink = [ "/share/nvim" ];
}
