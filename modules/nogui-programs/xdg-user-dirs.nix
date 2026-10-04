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
  hjem.users.${userName} = {
    xdg.config.files = {
      "user-dirs.dirs".text = ''
        XDG_DESKTOP_DIR="${hjemCfg.directory}/.xdg/Desktop"
        XDG_DOCUMENTS_DIR="${hjemCfg.directory}/.xdg/Documents"
        XDG_PUBLICSHARE_DIR="${hjemCfg.directory}/.xdg/Public"
        XDG_TEMPLATES_DIR="${hjemCfg.directory}/.xdg/Templates"

        XDG_DOWNLOAD_DIR="${hjemCfg.directory}/downloads"

        XDG_MUSIC_DIR="${hjemCfg.directory}/media/music"
        XDG_PICTURES_DIR="${hjemCfg.directory}/media/pictures"
        XDG_VIDEOS_DIR="${hjemCfg.directory}/media/videos"

        XDG_SCRIPTS_DIR="${hjemCfg.directory}/scripts"
        XDG_WORKSPACES_DIR="${hjemCfg.directory}/workspaces"

        XDG_HOME_BIN="${hjemCfg.directory}/bin"
      '';
    };

    environment.sessionVariables = {
      XDG_CONFIG_HOME = hjemCfg.xdg.config.directory;
      XDG_CACHE_HOME = hjemCfg.xdg.cache.directory;
      XDG_DATA_HOME = hjemCfg.xdg.data.directory;
      XDG_STATE_HOME = hjemCfg.xdg.state.directory;

      XDG_DESKTOP_DIR = "${hjemCfg.directory}/.xdg/Desktop";
      XDG_DOCUMENTS_DIR = "${hjemCfg.directory}/.xdg/Documents";
      XDG_PUBLICSHARE_DIR = "${hjemCfg.directory}/.xdg/Public";
      XDG_TEMPLATES_DIR = "${hjemCfg.directory}/.xdg/Templates";

      XDG_DOWNLOAD_DIR = "${hjemCfg.directory}/downloads";

      XDG_MUSIC_DIR = "${hjemCfg.directory}/media/music";
      XDG_PICTURES_DIR = "${hjemCfg.directory}/media/pictures";
      XDG_VIDEOS_DIR = "${hjemCfg.directory}/media/videos";

      XDG_SCRIPTS_DIR = "${hjemCfg.directory}/scripts";
      XDG_WORKSPACES_DIR = "${hjemCfg.directory}/workspaces";

      XDG_HOME_BIN = "${hjemCfg.directory}/bin";
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
