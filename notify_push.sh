#! /usr/bin/env nix-shell
#! nix-shell --pure
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash cacert curl
set -eu

urlfile="$1"

if [ -f "$urlfile" ]; then
  curl --no-progress-meter "$(cat "$urlfile")" -o /dev/null
fi
