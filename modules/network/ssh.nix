{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.network.ssh;
  inherit (myvar) userName;
in
{
  options.mymod.network.ssh = {
    config = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Configuration text write to `~/.ssh/config`.
        See `ssh_config(5)` for help.
      '';
    };
  };

  config = {
    services.openssh = {
      enable = true;
      ports = [ 6229 ];
      banner = "Welcome to ${userName}'s Space! Ciallo～(∠·ω< )⌒★ ";
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "${userName}" ];
      };
    };

    programs.ssh = {
      startAgent = true;
    };

    hjem.users.${userName} = {
      environment.sessionVariables = {
        SSH_AUTH_SOCK = "\${XDG_RUNTIME_DIR}/ssh-agent.socket";
      };

      files = {
        ".ssh/config".text = cfg.config;
      };
    };
  };
}
