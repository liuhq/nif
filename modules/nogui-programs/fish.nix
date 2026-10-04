{
  config,
  pkgs,
  lib,
  myvar,
  paths,
  ...
}:
let
  inherit (myvar) userName;
  inherit (paths) external;
  cfg = config.mymod.fish;
  hjemCfg = config.hjem.users.${userName};
in
{
  options.mymod = {
    fish.enable = lib.mkEnableOption "zsh";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
    ];

    programs.fish = {
      enable = true;
    };
  };
}
