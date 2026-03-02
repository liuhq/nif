{
  lib,
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation {
  pname = "misans";
  version = "4.003"; # from font metadata

  src = fetchzip {
    url = "https://hyperos.mi.com/font-download/MiSans.zip";
    hash = "sha256-MH4t7oXDUiH1TAm0xKa0AENmB1zoedd8X5BcQFNw8GM=";
    stripRoot = false;
  };

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  doCheck = false;
  dontFixup = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 -t $out/share/fonts/ttf MiSans/ttf/MiSans-*

    runHook postInstall
  '';

  meta = {
    homepage = "https://hyperos.mi.com/font/";
    description = "MiSans font";
    platforms = lib.platforms.all;
    license = lib.licenses.unfree; # https://hyperos.mi.com/font-download/MiSans字体知识产权许可协议.pdf
  };
}
