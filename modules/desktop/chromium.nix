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
    programs.chromium = {
      enable = true;
      extraOpts = {
        "BrowserSignin" = 1;
      };
    };

    environment.systemPackages = with pkgs; [
      (chromium.override {
        enableWideVine = true;
        commandLineArgs = [
          "--enable-features=AcceleratedVideoDecodeLinuxGL,AcceleratedVideoDecodeLinuxZeroCopyGL,AcceleratedVideoEncoder,VaapiVideoDecoder,VaapiIgnoreDriverChecks,WaylandLinuxDrmSyncobj"
          "--ignore-gpu-blocklist"
          "--enable-zero-copy"

          "--wayland-text-input-version=3"
          "--wayland-linux-drm-syncobj"

          "--enable-parallel-downloading"
          "--disk-cache-dir=/var/cache/chromium-cache"
        ];
      })
    ];

    hjem.users.${userName}.environment.sessionVariables = {
      BROWSER = "${lib.getExe pkgs.chromium}";
    };
  };
}
