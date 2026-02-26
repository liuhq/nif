{
  config,
  pkgs,
  lib,
  paths,
  ...
}:
let
  inherit (paths) external;
in
{
  programs.yazi = {
    enable = true;
    plugins = {
      inherit (pkgs.yaziPlugins) jump-to-char git mime-ext;
    };
    flavors = {
      nord = "${external}/yazi/flavors/nord.yazi";
    };
    initLua = "${external}/yazi/init.lua";
    settings = {
      yazi = lib.importTOML "${external}/yazi/yazi.toml";
      keymap = lib.importTOML "${external}/yazi/keymap.toml";
      theme = lib.importTOML "${external}/yazi/theme.toml";
    };
  };
}
