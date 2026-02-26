{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.desktop;
  inherit (myvar) userName;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.qbittorrent ];

    hjem.users.${userName}.xdg.config.files = {
      "qBittorrent/watched_folders.json" = {
        generator = lib.generators.toJSON { };
        value = {
          "/home/${userName}/downloads/qbit/torrents" = {
            add_torrent_params = {
              category = "";
              content_layout = "Original";
              download_limit = -1;
              download_path = "/home/${userName}/downloads/qbit/temp";
              inactive_seeding_time_limit = 15;
              operating_mode = "AutoManaged";
              ratio_limit = 1;
              save_path = "/home/${userName}/downloads/qbit";
              seeding_time_limit = 60;
              share_limit_action = "Remove";
              skip_checking = false;
              ssl_certificate = "";
              ssl_dh_params = "";
              ssl_private_key = "";
              tags = [ ];
              upload_limit = -1;
              use_auto_tmm = false;
              use_download_path = true;
            };
            recursive = false;
          };
        };
      };
    };
  };
}
