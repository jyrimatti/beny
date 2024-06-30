#! /usr/bin/env nix-shell
#! nix-shell -i dash --pure --keep CREDENTIALS_DIRECTORY -I channel:nixos-23.11-small -p dash coreutils xxd netcat nix flock

ret="$(dash ./beny_cmd.sh "3062303030316532343037303964" | tr -d '\n' | head -c 84 | tail -c 1)"
if [ "$ret" = "3" ]; then
    echo 0
else
    echo 1
fi
