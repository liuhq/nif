function runspt() {
  local script_file=$1
  local script_path="$HOME/scripts/$script_file"

  if [[ -z "$script_file" ]]; then
    echo "Usage: runspt <script_name> [args...]" >&2
    return 1
  fi

  if [[ ! -f "$script_path" ]]; then
    echo "Error: Script not found: $script_path" >&2
    return 1
  fi

  if [[ ! -x "$script_path" ]]; then
    echo "Error: No execute permission: $script_path" >&2
  fi

  shift
  "$script_path" "$@"
}

_scripts_files() {
  local scripts_dir="$HOME/scripts"

  [[ -d "$scripts_dir" ]] || return 1

  local -a files
  files=("$scripts_dir"/*(.N:t))

  [[ ${#files} -eq 0 ]] && return 1

  _describe -t scripts "available scripts:" files
}

_runspt_complete() {
  local curcontext="$curcontext" state line
  typeset -A opt_args

  _arguments -C \
    '1:scripts file:_scripts_files' \
    '*:path:_path_files'
}

compdef _runspt_complete runspt
