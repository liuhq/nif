{
  config,
  pkgs,
  lib,
  paths,
  myvar,
  ...
}:
let
  inherit (paths) external;
  inherit (myvar) userName;
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

  programs.fish.shellFunctions = {
    y = {
      body = ''
        set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if test -f "$tmp"
          set -l cwd (cat -- "$tmp")
          if test -n "$cwd"; and test "$cwd" != "$PWD"
            builtin cd -- "$cwd"
          end
        end
        rm -f -- "$tmp" >/dev/null
      '';
      modifiers = {
        description = "Quit and change dir in yazi";
      };
    };
  };
}
