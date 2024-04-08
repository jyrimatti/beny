#! /usr/bin/env nix-shell
#! nix-shell -i dash --pure -I channel:nixos-23.11-small -p dash coreutils xxd netcat nix

getset="${1:-}"

if [ "$getset" = "Set" ]; then
  dash ./beny_cmd.sh '35356161303030303131303030316532343036623031303030303030313130386238' >&2
  echo 0
else
  ret="$(dash ./beny_cmd.sh '35356161303030303062303030316532343037313965' | head -c 60 | tail -c 1)"
  if [ "$ret" = "0" ]; then
      echo 1
  else
      echo 0
  fi
fi
