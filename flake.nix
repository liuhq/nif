{
  description = "NixOS configuration";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
      "https://noctalia.cachix.org"
      "https://fenix.cachix.org"
      "https://cache.numtide.com"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "fenix.cachix.org-1:ecJhr+RdYEdcVgUkjruiYhjbBloIEGov7bos90cZi0Q="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
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
      inputs.nixpkgs.follows = "nixpkgs";
      # optionally choose not to download darwin deps (saves some resources on Linux)
      inputs.darwin.follows = "";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    eza = {
      url = "github:eza-community/eza";
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
      eachSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
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
