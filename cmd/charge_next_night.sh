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
  if [ "$value" = "0" ]; then
    ret="$(dash -x ./beny_cmd.sh "3535616130303030313930303031653234303639303030303030303030303030303030303030303030303030303030303135316630306438")"
  else
    time="30323030303030363030" # 02:00 - 06:00
    ret="$(dash -x ./beny_cmd.sh "353561613030303031393030303165323430363939396562636138393939656263613839${time}30303135313430303833")"
  fi
  echo "$value"
else
  ret="$(dash ./beny_cmd.sh '35356161303030303062303030316532343037303964' | tr -d '\n' | tail -c +85 | head -c 24)"
  if [ "$ret" = "303030303030303030303030" ]; then
      echo 0
  else
      echo 1
  fi
fi

