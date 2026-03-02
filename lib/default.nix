{ lib, ... }:
let
  scanPath =
    path:
    let
      dirContent = builtins.readDir path;
    in
    lib.mapAttrsToList (name: _type: path + "/${name}") (
      lib.filterAttrs (
        name: _type: (_type == "directory") || (name != "default.nix" && lib.strings.hasSuffix ".nix" name)
      ) dirContent
    );

  scanModules =
    path:
    let
      modules = scanPath path;
    in
    builtins.concatLists (
      lib.map (
        p:
        let
          isDir = lib.pathIsDirectory p;
        in
        if isDir then scanPath p else [ p ]
      ) modules
    );

  pathHelper = path: {
    addFile = filename: path + "/${filename}.nix";
    addFileSet = set: scanPath (path + "/${set}");
    addDir = dirname: path + "/${dirname}";
  };

  loadModules = mp: scanModules mp;
in
{
  mkSystemHelper =
    {
      inputs,
      globalSpecialArgs,
    }:
    {
      host,
      userName,
      nixosVersion ? "25.11",
      system ? "x86_64-linux",
      overlays ? [ ],
    }:
    let
      inherit (pathHelper globalSpecialArgs.paths.root) addFile addDir;
      specialArgs = globalSpecialArgs // {
        myvar = {
          inherit
            userName
            nixosVersion
            ;
          hostName = "${userName}-${host}";
        };
      };
    in
    inputs.nixpkgs.lib.nixosSystem {
      # DEBUG in non-NixOS
      inherit system;
      inherit specialArgs;
      modules = [
        {
          nixpkgs = {
            inherit overlays;
          };
        }

        inputs.agenix.nixosModules.default
        (addFile "secrets/agenix")

        (
          { config, paths, ... }:
          {
            imports = loadModules paths.modules;
          }
        )

        (addDir "role/${userName}/${host}")

        (
          { config, ... }:
          {
            users.users.${userName} = {
              isNormalUser = true;
              description = userName;
              extraGroups = [ "wheel" ];
              hashedPasswordFile = config.age.secrets."passwd-${userName}".path;
            };
          }
        )

        inputs.hjem.nixosModules.default
        (
          { config, ... }:
          {
            hjem.users.${userName} = {
              clobberFiles = true;
            };
          }
        )

        inputs.nix-flatpak.nixosModules.nix-flatpak

        inputs.noctalia.nixosModules.default
      ];
    };

}
