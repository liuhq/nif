{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.dev.rust;
  inherit (myvar) userName;
in
{
  imports = [ ];

  options.mymod = {
    dev.rust = {
      enable = lib.mkEnableOption "Rust environment" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    hjem.users.${userName} = {
      environment.sessionVariables = {
        CARGO_HOME = "\${HOME}/.config/cargo";
        RUSTUP_HOME = "\${HOME}/.config/rustup";
      };
    };
  };
}
