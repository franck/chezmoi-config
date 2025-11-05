set -x NVIM_APPNAME editorconfig
set -x EDITOR nvim
set -x AWS_REGION eu-west-3

set -g fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# opencode
fish_add_path /home/franck/.opencode/bin
fish_add_path /home/franck/.pulumi/bin
fish_add_path /home/franck/bin
fish_add_path ./bin

mise activate fish | source

