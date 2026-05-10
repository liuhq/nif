{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.bat = {
    enable = true;
    settings = {
      theme = "Nord";
      style = "plain";
      wrap = "auto";
      tabs = "2";
      map-syntax = [ "\".ignore:Git Ignore\"" ];
    };
  };

  environment.shellAliases = {
    b = "bat";
    "b.help" = "bat --language=help";
    "b.json" = "bat --language=json";
    "b.yaml" = "bat --language=yaml";
    "b.toml" = "bat --language=toml";
    "b.md" = "bat --language=markdown";
    "b.full" = "bat --style=full";
  };
}
