#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep HOMEKIT_SH_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p dash coreutils findutils gnused jq
set -eu

aid="$1"
iid="$2"
value="$3"

event="$(jq -jcn '{characteristics: [{aid:$aid, iid:$iid, value:$value}]}' --argjson aid "$aid" --argjson iid "$iid" --argjson value "$value")"

find "$HOMEKIT_SH_RUNTIME_DIR/sessions" -path '*/subscriptions/*' -name "$aid.$iid"\
  | sed 's/subscriptions/events/'\
  | {
      read -r output
      echo -n "$event" > "$output.push.json"
  }
