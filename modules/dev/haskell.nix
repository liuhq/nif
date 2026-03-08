{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.mymod.dev.haskell;
in
{
  options.mymod = {
    dev.haskell = {
      enable = lib.mkEnableOption "use haskell as one of system scripts" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.ghc.withPackages (
        hsPkgs: with hsPkgs; [
          turtle
          shh
          shh-extras
        ]
      ))
    ];
  };
}
