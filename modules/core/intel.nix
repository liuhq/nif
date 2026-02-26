{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.mymod = {
    cpu.intel.enable = lib.mkEnableOption "Intel CPU";
  };

  config = lib.mkIf config.mymod.cpu.intel.enable {
    hardware.cpu.intel.updateMicrocode = true;
  };
}
