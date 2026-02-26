{ config, pkgs, ... }:
{
  # old home
  environment.systemPackages = with pkgs; [
    bash-language-server
    dot-language-server
    lua-language-server
    nixd
    rust-analyzer
    shfmt
    tailwindcss-language-server
    taplo
    typescript-language-server
    vscode-css-languageserver
    vscode-json-languageserver
    yaml-language-server
    yamlfmt
  ];
}
