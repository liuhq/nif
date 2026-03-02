{
  lib,
  stdenvNoCC,
  fetchzip,
  ...
}:
let
  appInfo = {
    pname = "bocchi-dyn-cursor";
    version = "20260301";
  };
in
stdenvNoCC.mkDerivation (finalAttrs: {
  inherit (appInfo) pname version;

  src = fetchzip {
    url = "https://github.com/liuhq/nix-resources/releases/download/${appInfo.version}/Bocchi_cursor.tar";
    hash = "sha256-plKpxmtslEIAy+s54gJix/K1j3Z5jQeDqXjGcyUxDgs=";
    stripRoot = false;
  };

  dontBuild = true;
  dontPatch = true;
  dontConfigure = true;
  doCheck = false;
  dontFixup = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    cp -r . $out/share/icons

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/liuhq/nix-resources";
    description = "MyNixOS Cursor";
    platforms = lib.platforms.all;
    license = lib.licenses.unlicense;
  };
})
