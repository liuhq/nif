{
  config,
  pkgs,
  myvar,
  ...
}:
let
  inherit (myvar) userName;
in
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "14d";
    options = "--delete-older-than 7d";
  };

  nix.settings.trusted-users = [ "${userName}" ];
}
