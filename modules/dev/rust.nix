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
      environment.sessionVariables =
        let
          CARGO_INSTALL_ROOT = "\${HOME}/.local/cargo";
        in
        {
          CARGO_HOME = "\${HOME}/.config/cargo";
          inherit CARGO_INSTALL_ROOT;
          RUSTUP_HOME = "\${HOME}/.config/rustup";

          PATH = [ CARGO_INSTALL_ROOT ];
        };

      xdg.config.files = {
        "zsh/completions/_cargo".text = ''
          #compdef cargo
          if command -v rustc >/dev/null 2>&1; then
            source "$(rustc --print sysroot)"/share/zsh/site-functions/_cargo
          fi
        '';
      };
    };
  };
}
