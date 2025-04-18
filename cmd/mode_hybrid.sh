#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash coreutils xxd netcat nix flock
set -eu

getset="${1:-}"

if [ "$getset" = "Set" ]; then
  response="$(dash ./beny_cmd.sh "35356161303030303131303030316532343036623031303030303030313130386239")"
  echo 1
else
  ret="$(dash ./beny_cmd.sh "3062303030316532343037313965" | head -c 60 | tail -c 1)"
  if [ "$ret" = "1" ]; then
      echo 1
  else
      echo 0
  fi
fi
