#! /usr/bin/env nix-shell
#! nix-shell -i dash --pure -I channel:nixos-23.11-small -p dash coreutils xxd netcat nix

dash ./beny_cmd.sh '3062303030316532343037303964'| tr -d '\n' | head -c 68 | tail -c 3 | tr '3' '.'
