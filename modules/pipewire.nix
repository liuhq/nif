{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.mymod.pipewire;
in
{
  options.mymod.pipewire = {
    enable = lib.mkEnableOption "Pipewire";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;

      jack.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pwvucontrol
    ];
  };
}
