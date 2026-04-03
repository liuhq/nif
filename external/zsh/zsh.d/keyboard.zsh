### Extend to /etc/zinputrc

################
### Keyboard ###
################
### create a zkbd compatible hash;
### to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Backspace]="${terminfo[kbs]}"

key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

### setup key accordingly
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char

[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete
[[ -n "${key[Control-Left]}" ]] && bindkey -- "${key[Control-Left]}" backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word
