#! /usr/bin/env nix-shell
#! nix-shell -i dash --pure --keep LD_LIBRARY_PATH -I channel:nixos-23.11-small -p dash coreutils xxd netcat nix

getset="${1:-}"

if [ "$getset" = "Set" ]; then
  response="$(dash ./beny_cmd.sh "3131303030316532343036623031303030303030313130386238")"
  echo 1
else
  ret="$(dash ./beny_cmd.sh "3062303030316532343037313965" | head -c 60 | tail -c 1)"
  if [ "$ret" = "0" ]; then
      echo 1
  else
      echo 0
  fi
fi
