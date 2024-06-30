#! /usr/bin/env nix-shell
#! nix-shell -i dash --pure --keep CREDENTIALS_DIRECTORY -I channel:nixos-23.11-small -p dash coreutils xxd netcat bc flock

cmd="$1"

. ./beny_env.sh

echo -n "${BENY_PREFIX}$cmd" | xxd -r -p | flock ./beny_env.sh nc -u -W1 "$BENY_HOST" "$BENY_PORT" | xxd -p
