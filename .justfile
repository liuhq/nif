[private]
@default:
  just --list

[group('Secret')]
[working-directory: 'secrets']
agenix-edit file key:
  nix run github:ryantm/agenix -- --edit {{file}} --identity {{key}}

[group('Secret')]
[working-directory: 'secrets']
agenix-rekey:
  nix run github:ryantm/agenix -- --rekey --verbose

# vim: set ts=2 sw=2 sts=2 et:
