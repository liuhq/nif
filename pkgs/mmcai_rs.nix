{
  lib,
  stdenvNoCC,
  fetchurl,
  autoPatchelfHook,
  openssl,
}:
let
  aiVersion = "1.2.7";
  aiHash = "sha256-6vFLxaz/x9iFvVvVlCuZ821imTAr6uNWsvxYB/5CZSs=";
  mmcaiVersion = "0.2.1";
  mmcaiHash = "sha256-Dhgp1kEdJaiHljhnok9aoSAbwTc+paYnvfPj7t5smU8=";

  authlib-injector = stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "authlib-injector";
    version = aiVersion;

    src = fetchurl {
      url = "https://github.com/yushijinhun/authlib-injector/releases/download/v${aiVersion}/authlib-injector-${aiVersion}.jar";
      hash = aiHash;
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/share/java
      cp $src $out/share/java/authlib-injector.jar
    '';

    meta = with lib; {
      description = "Build your own Minecraft authentication system";
      homepage = "https://github.com/yushijinhun/authlib-injector";
      license = licenses.agpl3Only;
      platforms = lib.platforms.x86_64;
      sourceProvenance = [ sourceTypes.binaryBytecode ];
    };
  });
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "mmcai_rs";
  version = mmcaiVersion;

  src = fetchurl {
    url = "https://github.com/CatMe0w/mmcai_rs/releases/download/v${mmcaiVersion}/mmcai_rs-linux-x86_64";
    hash = mmcaiHash;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ openssl ];
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/mmcai_rs
    chmod +x $out/bin/mmcai_rs
    ln -s ${authlib-injector}/share/java/authlib-injector.jar $out/bin/authlib-injector.jar
  '';

  meta = with lib; {
    description = "Prism Launcher x authlib-injector — add external auth to Prism Launcher";
    homepage = "https://github.com/CatMe0w/mmcai_rs";
    license = licenses.mit;
    mainProgram = "mmcai_rs";
    platforms = lib.platforms.x86_64;
  };
})
