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
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Extra configuration text prepended to {file}`ssh_config`. Other generated
        options will be added after a `Host *` pattern.
        See {manpage}`ssh_config(5)`
        for help.
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

      files =
        let
          baseConfig = ''
            Host gh github.com
                Hostname ssh.github.com
                Port 443
                User git
                IdentitiesOnly yes
                IdentityFile ~/.ssh/keys/github_auth

            Host aur aur.archlinux.org
                User aur
                IdentitiesOnly yes
                IdentityFile ~/.ssh/keys/aur
          '';
        in
        {
          ".ssh/config".text = lib.concatStringsSep "\n\n" (
            builtins.filter (s: s != "") (
              lib.map (s: lib.trim s) [
                cfg.extraConfig
                baseConfig
              ]
            )
          );
        };
    };
  };
}
