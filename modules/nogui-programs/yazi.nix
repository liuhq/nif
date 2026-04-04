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
  hjem.users.${userName}.xdg.config.files = {
    "zsh/zsh.d/yazi.zsh".text = ''
      #################
      ### Functions ###
      #################

      ### Quit and Change Dir in yazi
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp" >/dev/null
      }
    '';
  };
}
