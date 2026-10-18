set dotenv-load
set dotenv-required

gh_token := env('GH_TOKEN')

[private]
@default:
  just --list

[group('Nix')]
rebuild-switch-wkst:
  sudo nixos-rebuild switch --flake .#wkst --option access-tokens "github.com:{{gh_token}}"

[group('Nix')]
rebuild-boot-wkst:
  sudo nixos-rebuild boot --flake .#wkst --option access-tokens "github.com:{{gh_token}}"

[group('Nix')]
update:
  nix flake update --option access-tokens "github.com:{{gh_token}}"

[group('Nix')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

[group('Nix')]
gc:
  sudo nix store gc
  sudo nix-collect-garbage --delete-old

[group('Nix')]
[working-directory: 'external/sing-box']
fetch-hash:
  ./fetch-hash.sh

[group('Secret')]
[working-directory: 'secrets']
agenix-edit file key:
  agenix --edit {{file}} --identity {{key}}

[group('Secret')]
[working-directory: 'secrets']
agenix-rekey:
  agenix --rekey --verbose

search file:
  nix run github:nix-community/nix-index-database {{file}} --option access-tokens "github.com:{{gh_token}}"

# vim: set ts=2 sw=2 sts=2 et:
