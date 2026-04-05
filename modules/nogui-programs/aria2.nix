{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  inherit (myvar) userName;
in
{
  environment.systemPackages = [ pkgs.aria2 ];

  hjem.users.${userName} = {
    xdg.config.files."aria2/aria2.conf".source = pkgs.writeText "aria2-config" ''
      continue
      dir=/home/${userName}/downloads
      file-allocation=falloc
      log-level=warn
      max-connection-per-server=8
      split=32
      min-split-size=5M
    '';

    files."scripts/aria2c.bt.ts" = {
      type = "copy";
      permissions = "0550";
      text = ''
        #!/usr/bin/env -S deno run --allow-read --allow-sys --allow-env --allow-run --allow-net
        import { $, minimist } from "npm:zx@8.8.5"
        import process from "node:process"

        const args = minimist(process.argv.slice(2), {})

        const trackerlist = await fetch("https://cf.trackerslist.com/all_aria2.txt")
        const trackers = await trackerlist.text()

        const aria2c_flags = [
          "--split=64",
          "--max-connection-per-server=16",
          "--bt-max-peers=500",
          "--bt-enable-lpd=true",
          "--enable-peer-exchange=true",
          "--enable-dht=true",
          "--disk-cache=128M",
          "--max-upload-limit=1M",
          "--seed-ratio=1.0",
          "--seed-time=30",
        ]

        await $({
          stdio: "inherit",
        })`aria2c ''${aria2c_flags} --bt-tracker=''${trackers} ''${args._}`
      '';
    };
  };
}
