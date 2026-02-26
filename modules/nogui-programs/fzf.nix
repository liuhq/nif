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
  programs.fzf = {
    keybindings = true;
    fuzzyCompletion = true;
  };

  hjem.users.${userName} = {
    environment.sessionVariables = {
      FZF_DEFAULT_COMMAND = ''fd --type f --hidden --exclude ".git" --exclude "node_modules" --exclude ".cache"'';
      FZF_DEFAULT_OPTS_FILE = "\${XDG_CONFIG_HOME}/fzf/fzfrc";
    };

    xdg.config.files = {
      "fzf/fzfrc".source = pkgs.writeText "fzf-config" ''
        --color=fg:-1,fg+:#D8DEE9,bg:-1,bg+:#434C5E
        --color=hl:#88C0D0,hl+:#EBCB8B,info:#616E88,marker:#88C0D0
        --color=prompt:#88C0D0,spinner:#616E88,pointer:#8FBCBB,header:#616E88
        --color=border:#3B4252,label:#D8DEE9,query:#ECEFF4
        --preview-window="border-block"
        --padding="0"
        --margin="0,1"
        --prompt="♯ "
        --marker="+"
        --marker-multi-line="+│└"
        --pointer="▌"
        --separator="─"
        --scrollbar="│"
        --info="right"
        --multi
      '';
    };
  };
}
