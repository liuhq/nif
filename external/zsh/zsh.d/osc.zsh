### support the OSC-7 escape sequence
function osc7-pwd() {
  emulate -L zsh # also sets localoptions for us
  setopt extendedglob
  local LC_ALL=C
  printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$( ([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
  ((ZSH_SUBSHELL)) || osc7-pwd
}
autoload -Uz add-zsh-hook
add-zsh-hook -Uz chpwd chpwd-osc7-pwd

### support the OSC-133;A sequence
function precmd() {
  print -Pn "\e]133;A\e\\"
}
