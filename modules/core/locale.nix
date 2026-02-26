{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.mymod.locale;
  nospace = str: lib.filter (c: c == " ") (lib.stringToCharacters str) == [ ];
in
{
  options.mymod = {
    locale = {
      encode = lib.mkOption {
        type = lib.types.str;
        default = "en_US.UTF-8";
        example = "en_US.UTF-8";
        description = ''
          The default locale. It determines the language for program messages,
          the format for dates and times, sort order, and so on. Setting the
          default character set is done via {option}`i18n.defaultCharset`.
        '';
      };

      extra-encode = lib.mkOption {
        type = lib.types.either (lib.types.listOf lib.types.str) (lib.types.enum [ "all" ]);
        default = [
          "zh_CN.UTF8/UTF-8"
          "ja_JP.UTF8/UTF-8"
        ];
        example = [
          "zh_CN.UTF8/UTF-8"
          "ja_JP.UTF8/UTF-8"
        ];
        description = ''
          Additional locales that the system should support, besides the ones
          configured with {option}`i18n.defaultLocale` and
          {option}`i18n.extraLocaleSettings`.
          Set this to `"all"` to install all available locales.
        '';
      };

      timeZone = lib.mkOption {
        type = lib.types.nullOr (lib.types.addCheck lib.types.str nospace) // {
          description = "null or string without spaces";
        };
        default = "Asia/Shanghai";
        example = "Asia/Shanghai";
        description = ''
          The time zone used when displaying times and dates. See <https://en.wikipedia.org/wiki/List_of_tz_database_time_zones>
          for a comprehensive list of possible values for this setting.

          If null, the timezone will default to UTC and can be set imperatively
          using timedatectl.
        '';
      };
    };
  };

  config = with cfg; {
    time = { inherit timeZone; };

    i18n.defaultLocale = encode;
    i18n.extraLocales = extra-encode;

    i18n.extraLocaleSettings = {
      LC_CTYPE = encode;
      LC_ADDRESS = encode;
      LC_IDENTIFICATION = encode;
      LC_MEASUREMENT = encode;
      LC_MESSAGES = encode;
      LC_MONETARY = encode;
      LC_NAME = encode;
      LC_NUMERIC = encode;
      LC_PAPER = encode;
      LC_TELEPHONE = encode;
      LC_TIME = encode;
      LC_COLLATE = encode;
    };
  };
}
