#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash coreutils xxd netcat nix bc flock
set -eu

. ./beny_env.sh

dash ./beny_cmd.sh '3062303030316532343037303964' | tr -d '\n' | head -c 68 | tail -c 3 | convert | { read -r x; echo "scale=1; $x / 10" | bc -l; }
