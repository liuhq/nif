final: prev: {
  google-chrome = prev.google-chrome.override {
    commandLineArgs = prev.lib.concatStringsSep " " [
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
  };
}
