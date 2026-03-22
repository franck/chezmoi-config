fish_add_path "$HOME/.opencode/bin"
fish_add_path "$HOME/bin"

if status is-interactive
    if test -x "$HOME/.local/bin/mise"
        "$HOME/.local/bin/mise" activate fish | source
    end
end
