{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  inherit (myvar) userName;
  cfg = config.mymod.programs.git;
in
{
  options.mymod.programs.git =
    let
      gitIniType =
        with lib.types;
        let
          primitiveType = either str (either bool int);
          multipleType = either primitiveType (listOf primitiveType);
          sectionType = attrsOf multipleType;
          supersectionType = attrsOf (either multipleType sectionType);
        in
        attrsOf supersectionType;
    in
    {
      settings = lib.mkOption {
        type = gitIniType;
        default = { };
        description = ''
          Configuration written to {file}`$XDG_CONFIG_HOME/git/config`.
          See {manpage}`git-config(1)` for details.
        '';
      };
    };

  config = {
    mymod.programs.git.settings = {
      core.editor = lib.mkDefault "nvim";
      commit.gpgsign = lib.mkDefault true;
      tag.gpgSign = lib.mkDefault true;
      init.defaultBranch = lib.mkDefault "main";
      credential.helper = lib.mkDefault "gopass";
    };

    programs.git.enable = true;

    environment.systemPackages = lib.mkIf (cfg.settings.credential.helper == "gopass") [
      pkgs.git-credential-gopass
    ];

    hjem.users.${userName}.xdg.config.files = {
      "git/config" = {
        generator = lib.generators.toGitINI;
        value = cfg.settings;
      };
    };
  };
}
