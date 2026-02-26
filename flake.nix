{
  description = "NixOS configuration";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      # optionally choose not to download darwin deps (saves some resources on Linux)
      inputs.darwin.follows = "";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      ...
    }@inputs:
    let
      paths = {
        root = ./.;
        modules = ./modules;
        localPkgs = ./pkgs;
        external = ./external;
      };
      mylib = import ./lib { inherit (inputs.nixpkgs) lib; };
      globalSpecialArgs = {
        inherit
          inputs
          mylib
          paths
          ;
      };
      mkSystem = mylib.mkSystemHelper { inherit inputs globalSpecialArgs; };
    in
    {
      nixosConfigurations.wkst = mkSystem {
        host = "wkst";
        userName = "horin";
      };
    };
}
