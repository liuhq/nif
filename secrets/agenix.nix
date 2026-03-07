{
  config,
  pkgs,
  inputs,
  myvar,
  ...
}:
let
  inherit (myvar) userName;
in
{
  environment.systemPackages = [ inputs.agenix.packages.x86_64-linux.default ];

  age.identityPaths = [ "./key" ];

  age.secrets."passwd-${userName}".file = ./passwd/${userName}.age;
  age.secrets.proxies.file = ./proxies.age;
}
