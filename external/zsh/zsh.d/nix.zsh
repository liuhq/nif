function runix() {
  PKG=$1
  shift 1
  nix run "nixpkgs#$PKG" -- "$@"
}
