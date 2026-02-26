{
  config,
  pkgs,
  myvar,
  ...
}:
let
  inherit (myvar) nixosVersion;
in
{
  # system.stateVersion = nixosVersion;

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
