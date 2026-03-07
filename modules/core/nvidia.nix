{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.mymod = {
    gpu.nvidia.enable = lib.mkEnableOption "Nvidia GPU";
  };

  config = lib.mkIf config.mymod.gpu.nvidia.enable {
    hardware.graphics = {
      enable = true;
      # for 32bit applications, like steam
      enable32Bit = true;
    };

    hardware.nvidia = {
      open = true;

      # for Wayland
      modesetting.enable = true;

      nvidiaSettings = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
