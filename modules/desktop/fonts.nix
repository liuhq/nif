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
    fonts.packages = [
      pkgs.ttf-misans

      pkgs.maple-mono.NF-CN
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk-sans
      pkgs.noto-fonts-cjk-serif
      pkgs.noto-fonts-color-emoji
    ];

    # https://wiki.nixos.org/wiki/Fonts#Solution_1:_Copy_fonts_to_$HOME/.local/share/fonts
    fonts.fontDir.enable = true;
    hjem.users.${userName}.xdg.data.files = {
      "fonts".source = "/run/current-system/sw/share/X11/fonts";
    };

    fonts.fontconfig = {
      enable = true;

      defaultFonts.serif = [
        "Noto Serif"
        "Noto Serif CJK SC"
        "Noto Color Emoji"
      ];

      defaultFonts.sansSerif = [
        "MiSans"
        "Noto Sans"
        "Noto Sans CJK SC"
        "Noto Color Emoji"
      ];

      defaultFonts.monospace = [
        "Maple Mono NF CN"
        "Noto Sans Mono CJK SC"
        "Noto Color Emoji"
      ];

      defaultFonts.emoji = [
        "Noto Color Emoji"
      ];

      localConf = ''
        <!-- Replace monospace fonts -->
        <match target="pattern">
          <test name="family" compare="contains">
            <string>Source Code</string>
          </test>
          <edit name="family" binding="strong">
            <string>Maple Mono NF CN</string>
          </edit>
        </match>

        <!-- Replace serif fonts -->
        <match target="pattern">
          <test name="lang">
            <string>zh-HK</string>
          </test>
          <test name="family">
            <string>Noto Serif CJK SC</string>
          </test>
          <edit name="family" binding="strong">
            <string>Noto Serif CJK TC</string>
          </edit>
        </match>

        <match target="pattern">
          <test name="lang">
            <string>zh-TW</string>
          </test>
          <test name="family">
            <string>Noto Serif CJK SC</string>
          </test>
          <edit name="family" binding="strong">
            <string>Noto Serif CJK TC</string>
          </edit>
        </match>

        <match target="pattern">
          <test name="lang">
            <string>ja</string>
          </test>
          <test name="family">
            <string>Noto Serif CJK SC</string>
          </test>
          <edit name="family" binding="strong">
            <string>Noto Serif CJK JP</string>
          </edit>
        </match>

        <match target="pattern">
          <test name="lang">
            <string>ko</string>
          </test>
          <test name="family">
            <string>Noto Serif CJK SC</string>
          </test>
          <edit name="family" binding="strong">
            <string>Noto Serif CJK KR</string>
          </edit>
        </match>
      '';
    };
  };
}
