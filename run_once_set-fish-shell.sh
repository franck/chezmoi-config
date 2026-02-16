#!/bin/sh

set -eu

if ! command -v fish >/dev/null 2>&1; then
  exit 0
fi

current_shell=$(getent passwd "$USER" | cut -d: -f7)

if [ "$current_shell" = "/usr/bin/fish" ]; then
  exit 0
fi

chsh -s /usr/bin/fish "$USER"
