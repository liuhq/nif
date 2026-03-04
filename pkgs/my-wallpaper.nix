{
  lib,
  stdenvNoCC,
  fetchzip,
  ...
}:
let
  appInfo = {
    pname = "my-wallpaper";
    version = "20260301";
  };
in
stdenvNoCC.mkDerivation (finalAttrs: {
  inherit (appInfo) pname version;

  src = fetchzip {
    url = "https://github.com/liuhq/nix-resources/releases/download/${appInfo.version}/wallpaper.tar";
    hash = "sha256-vaMqpEq1bZu6sBKozaQAX9wMqxujO+V8t99xy5hQEus=";
    stripRoot = false;
  };

  dontBuild = true;
  dontPatch = true;
  dontConfigure = true;
  doCheck = false;
  dontFixup = true;

  installPhase = ''
    runHook preInstall

    cp -r . $out

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/liuhq/nix-resources";
    description = "MyNixOS Wallpaper";
    platforms = lib.platforms.all;
    license = lib.licenses.unlicense;
  };
})
