let
  wkst = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAYa7ntaL5q/7oXyU3+j22YbhK62jKqYKNHSzH67bHIV nif";
  hosts = [ wkst ];

  armored = {
    publicKeys = hosts;
    armor = true;
  };
in
{
  "passwd/horin.age" = armored;
  "proxies.age" = armored;
  "proxies-mihomo.age" = armored;
}
