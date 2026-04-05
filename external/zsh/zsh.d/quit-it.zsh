function quit-kook() {
  local PS=("${(@f)$(ps aux | rg '[K]OOK' | awk '{print $2}')}")
  echo "$PS"
  kill $PS
}
