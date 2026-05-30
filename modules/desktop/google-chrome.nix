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
    environment.systemPackages = [ pkgs.google-chrome ];

    programs.chromium = {
      enable = true;
      extraOpts = {
        "AccessCodeCastEnabled" = true;
        "EnableMediaRouter" = true;
        "BrowserSignin" = 1;
        "DiskCacheDir" = "/var/cache/google-chrome-cache";
        "ForcedLanguages" = [
          "en-US"
          "zh-CN"
        ];
        "GoogleSearchSidePanelEnabled" = false;
        "AIModeSettings" = 1;
        "GenAiDefaultSettings" = 2;
        "GenAILocalFoundationalModelSettings" = 1;
      };
    };

    hjem.users.${userName}.environment.sessionVariables = {
      BROWSER = lib.getExe pkgs.google-chrome;
    };
  };
}
