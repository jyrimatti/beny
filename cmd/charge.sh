#! /usr/bin/env nix-shell
#! nix-shell -i dash --pure -I channel:nixos-23.11-small -p dash coreutils xxd netcat nix

getset="${1:-}"
value="${4:-}"
if [ "$value" = "true" ] || [ "$value" = "1" ]; then
  value="1";
else
  value="0";
fi

if [ "$getset" = "Set" ]; then
  if [ "$value" = "1" ]; then
    response="$(dash ./beny_cmd.sh "30633030303165323430303630313335")"
  else
    response="$(dash ./beny_cmd.sh "30633030303165323430303630303334")"
  fi
  echo "$value"
else
  ret="$(dash ./beny_cmd.sh "3062303030316532343037303964" | tr -d '\n' | head -c 80 | tail -c 1)"
  if [ "$ret" = "6" ]; then
      echo 1
  else
      echo 0
  fi
fi

