{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.starship = {
    enable = true;
    settings = {
      format = "[♪ ](bold bright-blue)$hostname$localip$shlvl$directory$package$git_branch$git_commit$git_state$git_metrics$git_status$nix_shell$fill$cmd_duration$status$jobs$container$time$line_break$sudo$character";
      add_newline = true;

      character = {
        format = "$symbol ";
        success_symbol = "[󰅂](bold white)";
        error_symbol = "[󰅂](bold red)";
        vimcmd_symbol = "[](bold green)";
        vimcmd_replace_one_symbol = "[](bold purple)";
        vimcmd_replace_symbol = "[](bold purple)";
        vimcmd_visual_symbol = "[](bold cyan)";
      };
      fill = {
        symbol = " ";
      };
      cmd_duration = {
        style = "bold cyan";
        show_milliseconds = true;
      };
      status = {
        disabled = false;
        format = "[$symbol$status]($style) ";
        style = "bold red";
        symbol = " ";
      };
      jobs = {
        symbol = " ";
      };
      time = {
        disabled = false;
      };
      sudo = {
        disabled = false;
        format = "[$symbol]($style)";
        symbol = "♯ ";
        style = "bold bright-red";
      };
      shlvl = {
        disabled = false;
        format = "[$shlvl$symbol]($style) ";
        symbol = " ";
      };
      directory = {
        read_only = " 󰌾";
      };
      git_metrics = {
        disabled = false;
      };
      nix_shell = {
        # format = "via [$symbol$state(\($name\))]($style)";
        symbol = "󱄅 ";
        heuristic = true;
      };
      package = {
        symbol = " ";
        version_format = "\${raw}";
      };
    };
  };
}
