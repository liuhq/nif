{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  environment.systemPackages = [
    inputs.eza.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  environment.sessionVariables = {
    EZA_COLORS = "fi=0:sc=0:bu=35:tm=00;90:ur=34:uw=34:ux=34;32:ue=01;32:gr=34:gw=34:gx=34;32:tr=34:tw=34:tx=34;32:sn=32:nb=32:nk=32:nm=33:ng=31:nt=01;31:sb=32:ub=32:uk=32:um=33:ug=31:ut=01;31:uu=36:uR=33:un=0:gu=36:gR=33:gn=0:da=0";
  };

  environment.shellAliases =
    let
      opts = "--classify=always --color=always --hyperlink=auto";
      longOpts = "--group --time-style long-iso";
    in
    {
      ls = "eza --across ${opts}";
      lv = "eza --oneline ${opts}";
      ll = "eza --long --total-size ${opts} ${longOpts}";
      la = "eza --all --long ${opts} ${longOpts}";
      lla = "eza --all --long --total-size ${opts} ${longOpts}";
      "ls.tree" = "eza --tree ${opts} -L"; # usage: `ls.t <number>`
      "ll.tree" = "eza --long --total-size ${opts} ${longOpts} --tree -L"; # usage: `ll.tree <number>`
      "la.tree" = "eza --all --long ${opts} ${longOpts} --tree -L"; # usage: `la.tree <number>`
      "lla.tree" = "eza --all --long --total-size ${opts} ${longOpts} --tree -L"; # usage: `la.tree <number>`
      "ls.files" = "eza --oneline ${opts} --only-files";
      "ls.dirs" = "eza --oneline ${opts} --only-dirs";
      "ls.git" = "eza --all --long ${opts} ${longOpts} --git --git-repos";
    };
}
