#! /usr/bin/env nix-shell
#! nix-shell -i dash --pure --keep CREDENTIALS_DIRECTORY -I channel:nixos-24.11-small -p dash coreutils xxd netcat nix bc flock
set -eu

. ./beny_env.sh

dash ./beny_cmd.sh '3062303030316532343037303964' | tr -d '\n' | head -c 68 | tail -c 3 | convert | { read -r x; echo "scale=1; $x / 10" | bc -l; }
