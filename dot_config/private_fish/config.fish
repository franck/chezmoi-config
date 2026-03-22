set -x NVIM_APPNAME editorconfig
set -x EDITOR nvim
set -x AWS_REGION eu-west-3
set -g fish_greeting

if test -d "$HOME/.pulumi/bin"
    fish_add_path --global "$HOME/.pulumi/bin"
end

set -l os (uname -s)

if status is-interactive
    switch $os
    case Linux
        if type -q try
            eval (try init ~/src/tries | string collect)
        else if test -x ~/.local/try.rb
            ~/.local/try.rb init ~/src/tries | source
        end

        __cwd_bin_refresh
    end

    if type -q mise
        mise activate fish | source
    end

    if test -z "$SSH_AUTH_SOCK"
        eval (ssh-agent -c) > /dev/null
        ssh-add ~/.ssh/id_ed25519 2>/dev/null
    end
end
