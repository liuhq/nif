{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = [ pkgs.eza ];

  environment.sessionVariables = {
    EZA_COLORS = "fi=0:sc=0:bu=35:tm=00;90";
  };

  environment.shellAliases =
    let
      opts = "--classify=always --color=always --hyperlink";
      longOpts = "--group --time-style long-iso";
    in
    {
      ls = "eza --across ${opts}";
      lv = "eza --oneline ${opts}";
      ll = "eza --long --total-size ${opts} ${longOpts}";
      la = "eza --all --long ${opts} ${longOpts}";
      "ls.tree" = "eza --tree ${opts} -L"; # usage: `ls.t <number>`
      "ll.tree" = "eza --long --total-size ${opts} ${longOpts} --tree -L"; # usage: `ll.t <number>`
      "la.tree" = "eza --all --long ${opts} ${longOpts} --tree -L"; # usage: `la.t <number>`
      "ls.files" = "eza --oneline ${opts} --only-files";
      "ls.dirs" = "eza --oneline ${opts} --only-dirs";
      "ls.git" = "eza --all --long ${opts} ${longOpts} --git --git-repos";
    };
}
