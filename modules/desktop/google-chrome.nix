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
    environment.systemPackages = [
      (pkgs.google-chrome.override {
        commandLineArgs = lib.concatStringsSep " " [
          "--ozone-platform-hint=wayland"

          "--enable-features=AcceleratedVideoDecodeLinuxGL,AcceleratedVideoDecodeLinuxZeroCopyGL,AcceleratedVideoEncoder,VaapiVideoDecoder,VaapiIgnoreDriverChecks,WaylandLinuxDrmSyncobj"
          "--disable-features=WaylandWpColorManagerV1"

          "--ignore-gpu-blocklist"
          "--enable-gpu-rasterization"
          "--enable-zero-copy"

          "--enable-wayland-ime"
          "--wayland-text-input-version=3"
          "--wayland-linux-drm-syncobj"

          "--enable-parallel-downloading"
        ];
      })
    ];

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
      BROWSER = "google-chrome-stable";
    };
  };
}
