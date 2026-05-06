{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.dev.gh;
  inherit (myvar) userName;
in
{
  imports = [ ];

  options.mymod = {
    dev.gh = {
      enable = lib.mkEnableOption "Github CLI" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.gh ];

    hjem.users.${userName}.xdg.config.files = {
      "gh/config.yml".text = ''
        version: 1
        git_protocol: ssh
        editor:
        prompt: enabled
        prefer_editor_prompt: disabled
        pager:
        aliases:
            # co: pr checkout
        http_unix_socket:
        browser:
        color_labels: enabled
        accessible_colors: disabled
        accessible_prompter: disabled
        spinner: enabled
        telemetry: disabled
      '';
      "gh/hosts.yml".text = ''
        github.com:
            git_protocol: ssh
            users:
                liuhq:
            user: liuhq
      '';
    };
  };
}
