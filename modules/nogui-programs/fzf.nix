{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  inherit (myvar) userName;
  hjemCfg = config.hjem.users.${userName};
in
{
  programs.fzf = {
    keybindings = true;
    fuzzyCompletion = true;
  };

  hjem.users.${userName} = {
    environment.sessionVariables = {
      FZF_DEFAULT_COMMAND = ''${lib.getExe pkgs.fd} --type f --hidden --exclude ".git" --exclude "node_modules" --exclude ".cache"'';
      FZF_DEFAULT_OPTS_FILE = "${hjemCfg.xdg.config.directory}/fzf/fzfrc";
    };

    xdg.config.files = {
      "fzf/fzfrc".source = pkgs.writeText "fzf-config" ''
        --color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796
        --color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6
        --color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796
        --color=selected-bg:#494D64
        --color=border:#6E738D,label:#CAD3F5
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
