{
  config,
  pkgs,
  myvar,
  ...
}:
let
  inherit (myvar) userName;
in
{
  imports = [
    # ./hardware-configuration.nix
  ];

  mymod.cpu.intel.enable = true;
  mymod.gpu.nvidia.enable = true;

  mymod.boot.systemd-boot.enable = true;
  mymod.displayManager.greetd.enable = true;

  mymod.network.networkmanager.enable = true;
  mymod.network.mihomo.enable = true;
  mymod.network.ssh.config = ''
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

  mymod.desktop.enable = true;

  mymod.zsh.enable = true;

  users.users.${userName} = {
    shell = pkgs.zsh;
  };

  mymod.programs.git.settings = {
    user = {
      name = "Horace Liu";
      email = "im.liuhq@gmail.com";
      signingkey = "/home/${userName}/.ssh/keys/git_sign.pub";
    };
    gpg = {
      format = "ssh";
    };
    sendemail = {
      smtpserver = "smtp.gmail.com";
      smtpuser = "im.liuhq@gmail.com";
      smtpencryption = "tls";
      smtpserverport = 587;
      annotate = true;
    };
  };
}
