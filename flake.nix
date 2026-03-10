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
      nixpkgs,
      ...
    }@inputs:
    let
      eachSystem = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.linux;
      paths = {
        root = ./.;
        modules = ./modules;
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
      packages =
        let
          callPackage = system: package: nixpkgs.legacyPackages.${system}.callPackage package { };
        in
        eachSystem (system: {
          ttf-misans = callPackage system ./pkgs/ttf-misans.nix;
          bocchi-dyn-cursor = callPackage system ./pkgs/bocchi-dyn-cursor.nix;
          my-wallpaper = callPackage system ./pkgs/my-wallpaper.nix;
        });

      overlays.default = nixpkgs.lib.composeManyExtensions [
        (import ./overlays/neovim.nix)
        (import ./overlays/colloid-icon-theme.nix)

        (final: prev: { ttf-misans = final.callPackage ./pkgs/ttf-misans.nix { }; })
        (final: prev: { bocchi-dyn-cursor = final.callPackage ./pkgs/bocchi-dyn-cursor.nix { }; })
        (final: prev: { my-wallpaper = final.callPackage ./pkgs/my-wallpaper.nix { }; })
      ];

      nixosConfigurations.wkst = mkSystem {
        host = "wkst";
        userName = "horin";
        overlays = [ self.overlays.default ];
      };
    };
}
