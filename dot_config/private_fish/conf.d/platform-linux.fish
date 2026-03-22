if test -d "$HOME/.local/share/omarchy/bin"
    fish_add_path --global "$HOME/.local/share/omarchy/bin"
end

function __cwd_bin_refresh --on-variable PWD
    set -l cwd_bin "$PWD/bin"
    set -l home_regex (string escape --style=regex -- $HOME)
    set -l new_path

    for p in $PATH
        if string match -q -- "$cwd_bin" $p
            continue
        end

        if string match -q -- "$HOME/.pulumi/bin" $p
            set -a new_path $p
            continue
        end

        if string match -q -- "$HOME/.local/share/omarchy/bin" $p
            set -a new_path $p
            continue
        end

        if string match -q -- "$HOME/.opencode/bin" $p
            set -a new_path $p
            continue
        end

        if string match -qr "^$home_regex/.local/share/mise/.*/bin\$" -- $p
            set -a new_path $p
            continue
        end

        if string match -qr "^$home_regex/.*/bin\$" -- $p
            continue
        end

        set -a new_path $p
    end

    if test -d "$cwd_bin"
        set -gx PATH $cwd_bin $new_path
    else
        set -gx PATH $new_path
    end
end
