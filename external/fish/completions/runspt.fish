function __fish_runspt_scripts
    set -l scripts_dir "$HOME/scripts"
    test -d "$scripts_dir"; or return

    for script_path in "$scripts_dir"/*
        if test -f "$script_path"; and not test -L "$script_path"
            path basename -- "$script_path"
        end
    end
end

complete -c runspt -n __fish_is_first_arg -f -a '(__fish_runspt_scripts)' -d 'Script in ~/scripts'
