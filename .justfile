[private]
@default:
  just --list

[group('Nix')]
rebuild-switch:
  nixos-rebuild switch --flake .

[group('Nix')]
rebuild-boot:
  nixos-rebuild boot --flake .

[group('Nix')]
update:
  nix flake update

[group('Nix')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

[group('Nix')]
gc:
  sudo nix store gc
  sudo nix-collect-garbage --delete-old

[group('Secret')]
[working-directory: 'secrets']
agenix-edit file key:
  nix run github:ryantm/agenix -- --edit {{file}} --identity {{key}}

[group('Secret')]
[working-directory: 'secrets']
agenix-rekey:
  nix run github:ryantm/agenix -- --rekey --verbose

# vim: set ts=2 sw=2 sts=2 et:
