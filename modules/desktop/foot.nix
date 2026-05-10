{
  config,
  pkgs,
  lib,
  myvar,
  ...
}:
let
  cfg = config.mymod.desktop;
  inherit (myvar) userName;
  colors-dark = {
    cursor = "242933 D8DEE9";
    foreground = "d8dee9";
    background = "242933";

    regular0 = "2E3440";
    regular1 = "bf616a";
    regular2 = "a3be8c";
    regular3 = "ebcb8b";
    regular4 = "81a1c1";
    regular5 = "b48ead";
    regular6 = "88c0d0";
    regular7 = "e5e9f0";

    bright0 = "596377";
    bright1 = "bf616a";
    bright2 = "a3be8c";
    bright3 = "ebcb8b";
    bright4 = "81a1c1";
    bright5 = "b48ead";
    bright6 = "8fbcbb";
    bright7 = "eceff4";

    dim0 = "373e4d";
    dim1 = "94545d";
    dim2 = "809575";
    dim3 = "b29e75";
    dim4 = "68809a";
    dim5 = "8c738c";
    dim6 = "6d96a5";
    dim7 = "aeb3bb";

    selection-foreground = "4c566a";
    selection-background = "eceff4";
  };
in
{
  config = lib.mkIf cfg.enable {
    programs.foot = {
      enable = true;
      theme = "nord";
      settings = {
        # inherit colors-dark;
        main = {
          font = "monospace:size=12";
          box-drawings-uses-font-glyphs = "yes";
          selection-target = "none";
        };
        security = {
          osc52 = "enabled";
        };
        bell = {
          system = "no";
          notify = "yes";
        };
        scrollback = {
          lines = 2048;
          indicator-format = "percentage";
        };
        cursor = {
          style = "underline";
          unfocused-style = "unchanged";
          underline-thickness = 2;
        };
        mouse = {
          hide-when-typing = "yes";
        };
        key-bindings = {
          scrollback-up-page = "Shift+Page_Up Shift+KP_Page_Up";
          scrollback-up-half-page = "Control+Shift+u";
          scrollback-up-line = "Control+Shift+k";
          scrollback-down-page = "Shift+Page_Down Shift+KP_Page_Down";
          scrollback-down-half-page = "Control+Shift+d";
          scrollback-down-line = "Control+Shift+j";
          scrollback-home = "none";
          scrollback-end = "none";
          clipboard-copy = "XF86Copy Shift+Delete";
          clipboard-paste = "XF86Paste Shift+Insert";
          primary-paste = "Control+Shift+Insert";
          search-start = "Control+Shift+slash";
          font-increase = "none";
          font-decrease = "none";
          font-reset = "none";
          spawn-terminal = "Control+Shift+n";
          minimize = "none";
          maximize = "none";
          fullscreen = "none";
          # pipe-visible = "[sh -c "xurls | fuzzel | xargs -r firefox"] none";
          # pipe-scrollback = "[sh -c "xurls | fuzzel | xargs -r firefox"] none";
          # pipe-selected = "[xargs -r firefox] none";
          # pipe-command-output = "[wl-copy] none # Copy last command's output to the clipboard";
          show-urls-launch = "Control+Shift+o";
          show-urls-copy = "Control+Shift+y";
          show-urls-persistent = "none";
          prompt-prev = "Control+Shift+bracketleft";
          prompt-next = "Control+Shift+bracketright";
          unicode-input = "Control+Shift+q";
          noop = "none";
          quit = "none";
        };

        search-bindings = {
          cancel = "Escape";
          commit = "Return KP_Enter";
          find-prev = "Control+p";
          find-next = "Control+n";
          cursor-left = "Left";
          cursor-left-word = "Control+Left";
          cursor-right = "Right";
          cursor-right-word = "Control+Right";
          cursor-home = "Home Control+a";
          cursor-end = "End Control+e";
          delete-prev = "BackSpace";
          delete-prev-word = "Control+BackSpace";
          delete-next = "Delete";
          delete-next-word = "Control+Delete";
          delete-to-start = "none";
          delete-to-end = "none";
          extend-char = "Shift+Right";
          extend-to-word-boundary = "Control+Shift+Right";
          extend-to-next-whitespace = "none";
          extend-line-down = "Shift+Down";
          extend-backward-char = "Shift+Left";
          extend-backward-to-word-boundary = "Control+Shift+Left";
          extend-backward-to-next-whitespace = "none";
          extend-line-up = "Shift+Up";
          clipboard-paste = "Control+Shift+Insert";
          primary-paste = "Shift+Insert";
          unicode-input = "none";
          scrollback-up-page = "Shift+Page_Up Shift+KP_Page_Up";
          scrollback-up-half-page = "none";
          scrollback-up-line = "none";
          scrollback-down-page = "Shift+Page_Down Shift+KP_Page_Down";
          scrollback-down-half-page = "none";
          scrollback-down-line = "none";
          scrollback-home = "none";
          scrollback-end = "none";
        };

        url-bindings = {
          cancel = "Escape";
          toggle-url-visible = "t";
        };

        text-bindings = {
          # \x03=Mod4+c  # Map Super+c -> Ctrl+c
        };

        mouse-bindings = {
          scrollback-up-mouse = "BTN_WHEEL_BACK";
          scrollback-down-mouse = "BTN_WHEEL_FORWARD";
          font-increase = "none";
          font-decrease = "none";
          selection-override-modifiers = "Shift";
          primary-paste = "BTN_MIDDLE";
          select-begin = "BTN_LEFT";
          select-begin-block = "Control+BTN_LEFT";
          select-extend = "BTN_RIGHT";
          select-extend-character-wise = "Control+BTN_RIGHT";
          select-word = "BTN_LEFT-2";
          select-word-whitespace = "Control+BTN_LEFT-2";
          select-quote = " BTN_LEFT-3";
          select-row = "BTN_LEFT-4";
        };
      };
    };

    hjem.users.${userName}.environment.sessionVariables = {
      TERMINAL = "${lib.getExe pkgs.foot}";
    };
  };
}
