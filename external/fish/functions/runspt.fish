function runspt --description 'Run a script from ~/scripts'
    if not set -q argv[1]; or test -z "$argv[1]"
        echo 'Usage: runspt <script_name> [args...]' >&2
        return 1
    end

    set -l script_path "$HOME/scripts/$argv[1]"

    if not test -f "$script_path"
        echo "Error: Script not found: $script_path" >&2
        return 1
    end

    if not test -x "$script_path"
        echo "Error: No execute permission: $script_path" >&2
        return 1
    end

    command "$script_path" $argv[2..-1]
end
