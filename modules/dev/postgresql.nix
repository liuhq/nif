{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.dev.postgresql;
  inherit (myvar) userName;
in
{
  imports = [ ];

  options.mymod = {
    dev.postgresql = {
      enable = lib.mkEnableOption "PostgreSQL" // {
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.postgresql = {
      enable = true;
      ensureDatabases = [ userName ];
      ensureUsers = [
        {
          name = userName;
          ensureDBOwnership = true;
          ensureClauses = {
            login = true;
            password = "SCRAM-SHA-256$4096:q1rslKyfzy2tKAlgM7662A==$rSIQvkgUdUA08hIXXHvLzRGAJ23jK5OD7C9OPOA69n0=:KeA2xC8LEmSQ0HcZM7802pPea65vAOtxqEe/3FFHAcA=";
          };
        }
      ];
      # enableTCPIP = true;
      # settings = {
      #   ssl = true;
      # };
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
        #host  sameuser  all     127.0.0.1/32 scram-sha-256
        #host  sameuser  all     ::1/128 scram-sha-256
      '';
    };
  };
}
