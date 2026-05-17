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
  hjem.users.${userName} = {
    xdg.config.files = {
      "user-dirs.dirs".text = ''
        XDG_DESKTOP_DIR="$HOME/.xdg/Desktop"
        XDG_DOCUMENTS_DIR="$HOME/.xdg/Documents"
        XDG_PUBLICSHARE_DIR="$HOME/.xdg/Public"
        XDG_TEMPLATES_DIR="$HOME/.xdg/Templates"

        XDG_DOWNLOAD_DIR="$HOME/downloads"

        XDG_MUSIC_DIR="$HOME/media/music"
        XDG_PICTURES_DIR="$HOME/media/pictures"
        XDG_VIDEOS_DIR="$HOME/media/videos"

        XDG_SCRIPTS_DIR="$HOME/scripts"
        XDG_WORKSPACES_DIR="$HOME/workspaces"

        XDG_HOME_BIN="$HOME/bin"
      '';
    };

    environment.sessionVariables = {
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_DATA_HOME = "\${HOME}/.local/share";
      XDG_STATE_HOME = "\${HOME}/.local/state";

      XDG_DESKTOP_DIR = "\${HOME}/.xdg/Desktop";
      XDG_DOCUMENTS_DIR = "\${HOME}/.xdg/Documents";
      XDG_PUBLICSHARE_DIR = "\${HOME}/.xdg/Public";
      XDG_TEMPLATES_DIR = "\${HOME}/.xdg/Templates";

      XDG_DOWNLOAD_DIR = "\${HOME}/downloads";

      XDG_MUSIC_DIR = "\${HOME}/media/music";
      XDG_PICTURES_DIR = "\${HOME}/media/pictures";
      XDG_VIDEOS_DIR = "\${HOME}/media/videos";

      XDG_SCRIPTS_DIR = "\${HOME}/scripts";
      XDG_WORKSPACES_DIR = "\${HOME}/workspaces";

      XDG_HOME_BIN = "\${HOME}/bin";
    };
  };

  systemd.user.tmpfiles.rules = [
    "d %h/.xdg 0755 - - - -"
    "d %h/.xdg/Desktop 0755 - - - -"
    "d %h/.xdg/Documents 0755 - - - -"
    "d %h/.xdg/Public 0755 - - - -"
    "d %h/.xdg/Templates 0755 - - - -"

    "d %h/downloads 0755 - - - -"
    "h %h/downloads - - - - +C"

    "d %h/media 0755 - - - -"
    "d %h/media/music 0755 - - - -"
    "d %h/media/pictures 0755 - - - -"
    "d %h/media/videos 0755 - - - -"

    "d %h/scripts 0755 - - - -"
    "d %h/workspaces 0755 - - - -"

    "d %h/bin 0755 - - - -"
  ];
}
