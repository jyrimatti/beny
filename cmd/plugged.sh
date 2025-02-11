#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash coreutils xxd netcat nix flock
set -eu

ret="$(dash ./beny_cmd.sh "3062303030316532343037303964" | tr -d '\n' | head -c 84 | tail -c 1)"
if [ "$ret" = "3" ] || [ "$ret" = "1" ]; then
    echo 0
else
    echo 1
fi
