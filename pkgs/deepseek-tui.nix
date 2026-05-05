{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
  dbus,

  # for test
  python3,
  gitMinimal,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "deepseek-tui";
  version = "0.8.9";

  src = fetchFromGitHub {
    owner = "Hmbown";
    repo = "DeepSeek-TUI";
    tag = "v${finalAttrs.version}";
    hash = "sha256-jyAm4PxJiXtcQlenbNALdu5ot2uL5QuqVi73RGRBl/s=";
  };

  cargoHash = "sha256-jtufEDsVNmhdI7UsZVPV32Pprl7Ooa/mtlym/kp+ZGU=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    openssl
    dbus
  ];

  nativeCheckInputs = [
    python3
    gitMinimal
  ];

  cargoBuildFlags = [
    "--package"
    "deepseek-tui-cli"
    "--package"
    "deepseek-tui"
  ];
  cargoTestFlags = finalAttrs.cargoBuildFlags;

  meta = {
    description = "Coding agent for DeepSeek models that runs in your terminal";
    homepage = "https://github.com/Hmbown/DeepSeek-TUI";
    changelog = "https://github.com/Hmbown/DeepSeek-TUI/blob/${finalAttrs.src.tag}/CHANGELOG.md";
    license = lib.licenses.mit;
    mainProgram = "deepseek";
  };
})
