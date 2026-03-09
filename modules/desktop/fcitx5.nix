{
  config,
  pkgs,
  lib,
  myvar,
  paths,
  ...
}:
let
  cfg = config.mymod.desktop;
  inherit (myvar) userName;
  inherit (paths) external;
in
{
  config = lib.mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        qt6Packages.fcitx5-chinese-addons
        fcitx5-mozc

        fcitx5-gtk
        fcitx5-nord

        fcitx5-pinyin-moegirl
        fcitx5-pinyin-zhwiki
      ];

      fcitx5.waylandFrontend = true;

      fcitx5.quickPhraseFiles = {
        QuickPhrase = "${external}/fcitx5/QuickPhrase.mb";
      };
    };

    hjem.users.${userName}.xdg.config.files."fcitx5".source = "${external}/fcitx5/user";
  };
}
