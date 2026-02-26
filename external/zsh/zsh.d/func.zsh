#################
### Functions ###
#################

### Quit and Change Dir in yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp" > /dev/null
}

### support the OSC-7 escape sequence
function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
add-zsh-hook -Uz chpwd chpwd-osc7-pwd

### support the OSC-133;A sequence
function precmd() {
    print -Pn "\e]133;A\e\\"
}

function quit-kook() {
    PS=("${(@f)$(ps aux | rg '[K]OOK' | awk '{print $2}')}")
    echo "$PS"
    kill $PS
}
