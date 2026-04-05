{
  config,
  myvar,
  ...
}:
let
  inherit (myvar) userName;
in
{
  services.userborn = {
    enable = true;
    ## for immutable /etc: `system.etc.overlay.mutable = false;`
    # passwordFilesLocation = "/persistent/etc";
  };

  users.users.${userName} = {
    isNormalUser = true;
    description = userName;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.age.secrets."passwd-${userName}".path;
  };

  users.mutableUsers = false;
  users.users.root.isSystemUser = true;
}
