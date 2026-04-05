function runix() {
  local PKG=$1
  shift
  nix run "nixpkgs#$PKG" -- "$@"
}
