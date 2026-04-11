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

      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        libvdpau-va-gl
      ];
    };

    hardware.nvidia = {
      open = true;

      # for Wayland
      modesetting.enable = true;

      nvidiaSettings = true;

      powerManagement.enable = true;
      videoAcceleration = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
    };
  };
}
